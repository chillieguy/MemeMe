//
//  MemeMeTableVC.swift
//  MemeMeV1
//
//  Created by Chuck Underwood on 6/13/18.
//  Copyright © 2018 Chuck Underwood. All rights reserved.
//

import UIKit

class MemeMeTableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Data.memeArray.append(Meme(topText: "Top Test", BottomText: "Bottom Test", originalImage: #imageLiteral(resourceName: "memeTest.jpg"), memeImage: #imageLiteral(resourceName: "memeTest.jpg")))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
        tableView.reloadData()

    }
    
    @IBAction func newMeme(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemeMeVC") as! MemeMeVC
            present(vc, animated: true)
    }
    

}

extension MemeMeTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Data.memeArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MemeMeTableViewCell
        
        cell.setup(meme: Data.memeArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Different segue from collectionView for practice
        performSegue(withIdentifier: "ViewMeme", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailVC
        destinationVC.passedMeme = Data.memeArray[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            Data.memeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (action, indexPath) in
            let action = UIActivityViewController(activityItems: [Data.memeArray[indexPath.row].memeImage as Any], applicationActivities: nil)
            self.present(action, animated: true, completion: nil)
        }
        
        return [deleteAction, shareAction]
    }
    
}

extension MemeMeTableVC: UITableViewDelegate {
    
}

