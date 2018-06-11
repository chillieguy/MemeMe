//
//  MemeMeVC.swift
//  MemeMeV1
//
//  Created by Chuck Underwood on 5/25/18.
//  Copyright © 2018 Chuck Underwood. All rights reserved.
//

import UIKit

class MemeMeVC: UIViewController {
    
    // Mark - Global Variables
    var isSharingEnabled = false
    
    // Mark - @IBOutlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var memeViewContainer: UIView!
    @IBOutlet weak var introView: UIView!
    
    // Mark - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitViewProperties()
        
        // Set UITextField formatting
        setTextFormatting()
        
        // Set UITextField delegate
        topTextField.delegate = self
        bottomTextField.delegate = self
        
    }
    
    // Mark - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    // Mark - viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeToKeyboardNotifications()
    }
    

    // Mark - @IBActions
    @IBAction func shareAction(_ sender: Any) {
        let meme = Meme(topText: topTextField.text!, BottomText: bottomTextField.text!, originalImage: imageView.image!, memeImage: generateMeme())
        
        let activityVC = UIActivityViewController(activityItems: [meme.memeImage], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
       setInitViewProperties()
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        presentImagePicker(for: .camera)
    }
    
    @IBAction func albumAction(_ sender: Any) {
        presentImagePicker(for: .photoLibrary)
    }
    
    
    
    // Mark - Helper Functions
    
    func setTextFormatting() {
        let textFieldAttributes: [String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.strokeWidth.rawValue: -3,
            NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!
        ]
        
        topTextField.defaultTextAttributes = textFieldAttributes
        bottomTextField.defaultTextAttributes = textFieldAttributes
        
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
    }
    
    func presentImagePicker(for source: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        pickerController.allowsEditing = true
        present(pickerController, animated: true) {
            return
        }
    }
    
    func setInitViewProperties() {
        // Set text for textfields
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        // Disable shareButton until image is set
        isSharingEnabled = false
        shareButton.isEnabled = isSharingEnabled
        
        // Camera enabled if available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        
        
        // Set initial view state
        introView.isHidden = false
        memeViewContainer.isHidden = true
    }
    
    func positionTextFields() {
       
    }
    
    func generateMeme() -> UIImage {
        // Hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render view into an image
        UIGraphicsBeginImageContext(self.view.frame.size)
//        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        memeViewContainer.drawHierarchy(in: memeViewContainer.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Unhide navigation bar
        self.navigationController?.isNavigationBarHidden = false
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memeImage
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}

// Mark - UIImagePickerControllerDelegate

extension MemeMeVC: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        introView.isHidden = true
        memeViewContainer.isHidden = false
        shareButton.isEnabled = true
        
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        positionTextFields()
        
        dismiss(animated: true, completion: nil)
    }
}

// Mark - UINavigationControllerDelegate

extension MemeMeVC: UINavigationControllerDelegate {
    
}

// Mark - UITextFieldDelegate

extension MemeMeVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = nil
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

