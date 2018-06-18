//
//  MemeMeCollectionView.swift
//  MemeMeV1
//
//  Created by Chuck Underwood on 6/16/18.
//  Copyright © 2018 Chuck Underwood. All rights reserved.
//

import UIKit

class MemeMeCollectionView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
        collectionView.reloadData()

    }

    @IBAction func newMeme(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemeMeVC") as! MemeMeVC
        present(vc, animated: true) {
            return
        }
    }
    
}

extension MemeMeCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.memeArray.count
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! MemeMeCollectionViewCell
        
        cell.setup(meme: Data.memeArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ViewMeme", sender: nil)
    }
    
}

extension MemeMeCollectionView: UICollectionViewDelegate {
    
}
