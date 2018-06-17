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
        
        Data.memeArray.append(Meme(topText: "Top Test", BottomText: "Bottom Test", originalImage: #imageLiteral(resourceName: "memeTest.jpg"), memeImage: #imageLiteral(resourceName: "memeTest.jpg")))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        collectionView.reloadData()
    }

    @IBAction func newMeme(_ sender: Any) {
        performSegue(withIdentifier: "CreateMeme", sender: nil)
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
    
    
}

extension MemeMeCollectionView: UICollectionViewDelegate {
    
}
