//
//  MemeMeCollectionViewCell.swift
//  MemeMeV1
//
//  Created by Chuck Underwood on 6/16/18.
//  Copyright © 2018 Chuck Underwood. All rights reserved.
//

import UIKit

class MemeMeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    func setup(meme: Meme) {
        memeImage.image = meme.originalImage
        topLabel.text = meme.topText
        bottomLabel.text = meme.BottomText
        cardView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
}
