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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
    }

}
