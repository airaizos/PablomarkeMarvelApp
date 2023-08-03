//
//  HeroesCollectionViewCell.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 1/8/23.
//

import UIKit

class HeroesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var HeroeName: UILabel!
    @IBOutlet weak var backgroundName: UIImageView!
    @IBOutlet weak var HeroeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        HeroeImage.layer.cornerRadius = 18
        backgroundName.layer.cornerRadius = 18
    }

}
