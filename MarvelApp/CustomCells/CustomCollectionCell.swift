//
//  CustomCollectionCell.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 25/7/23.
//

import UIKit

final class CustomCollectionCell: UICollectionViewCell {

    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        favImage.contentMode = .scaleAspectFill
        favLabel.textColor = .white
        favImage.layer.cornerRadius = 12
        
    }

}
