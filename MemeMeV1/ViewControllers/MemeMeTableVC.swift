//
//  MemeMeTableVC.swift
//  MemeMeV1
//
//  Created by Chuck Underwood on 6/13/18.
//  Copyright © 2018 Chuck Underwood. All rights reserved.
//

import UIKit

class MemeMeTableVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension MemeMeTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension MemeMeTableVC: UITableViewDelegate {
    
}

