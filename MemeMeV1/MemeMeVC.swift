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
    
    
    // Mark - @IBOutlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // Mark - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // Mark - @IBActions
    @IBAction func shareAction(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    @IBAction func cameraAction(_ sender: Any) {
    }
    
    @IBAction func albumAction(_ sender: Any) {
    }
    
    // Mark - Helper Functions
}

