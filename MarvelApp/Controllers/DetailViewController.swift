//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    var model: HeroeData
    
    init(model: HeroeData) {
        self.model = model
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncModel()
        heroName.textColor = UIColor.black
        view.backgroundColor = UIColor(named: "myRed")
        backgroundImage.contentMode = .center
      
    }
    
    func syncModel() {
        heroName.text = model.name
        heroDescription.text = model.description
        
        let imageUrl = URL(string: model.thumbnail.ThumbnailComplete())
        heroImage.kf.setImage(with: imageUrl)
        backgroundImage.kf.setImage(with: imageUrl)
    }
}

