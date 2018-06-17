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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    @IBAction func newMeme(_ sender: Any) {
        performSegue(withIdentifier: "CreateMeme", sender: nil)
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
    
}

extension MemeMeTableVC: UITableViewDelegate {
    
}

