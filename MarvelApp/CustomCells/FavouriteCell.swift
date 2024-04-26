//
//  FavouriteCell.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 4/8/23.
//

import UIKit

final class FavouriteCell: UICollectionViewCell {

    @IBOutlet weak var favName: UILabel!
    @IBOutlet weak var forName: UIImageView!
    @IBOutlet weak var favImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        forName.layer.cornerRadius = 12
        favImage.layer.cornerRadius = 12
        favImage.contentMode = .scaleAspectFill
        favName.textColor = .white
        
    }

}
