//
//  DetailVC.swift
//  MemeMeV1
//
//  Created by Chuck Underwood on 6/17/18.
//  Copyright © 2018 Chuck Underwood. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var passedMeme: Meme?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
        imageView.image = passedMeme?.memeImage
    }

}
