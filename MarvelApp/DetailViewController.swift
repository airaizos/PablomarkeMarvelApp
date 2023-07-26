//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit



class DetailViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    var model: Heroe
    
    init(model: Heroe) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
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
        heroImage.image = model.image
        backgroundImage.image = model.image
    }
}

