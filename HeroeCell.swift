//
//  HeroeCell.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit

class HeroeCell: UITableViewCell {

    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heroeImage.contentMode = .scaleAspectFill
        
        
    }

    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        super.setSelected(selected,
                          animated: animated)
        
    }
  
}
