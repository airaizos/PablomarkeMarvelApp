//
//  LoginViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 23/7/23.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     // Buttons and Images
        
        logoImage.image = UIImage(named: "Logo")
        logoImage.contentMode = .scaleAspectFit
        
        loginImage.image = UIImage(named: "Universe")
        loginImage.contentMode = .scaleAspectFill
        
        enterButton.setTitle("Entrar",
                             for: .normal)
        enterButton.tintColor = UIColor(named: "myOrange")
    }
    
    //Button Action
    @IBAction func enterAction(_ sender: Any) {
        NetWorking.shared.getAllheroes(success: { allHeroes in
            let home = HomeViewController(allHeroes)
            self.navigationController?.pushViewController(home,
                                                          animated: true)
        }, failure: { error in
            print("Error")
        })
    }
}
