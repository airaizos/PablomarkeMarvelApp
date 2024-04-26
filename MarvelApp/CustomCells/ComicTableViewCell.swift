//
//  ComicTableViewCell.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 2/8/23.
//

import UIKit

final class ComicTableViewCell: UITableViewCell {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var comicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
