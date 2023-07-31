//
//  LoginViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 23/7/23.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        loginImage.image = UIImage(named: "Universe")
        logoImage.image = UIImage(named: "Logo")
        logoImage.contentMode = .scaleAspectFit
        
        loginImage.contentMode = .scaleAspectFill
        
        enterButton.setTitle("Entrar", for: .normal)
        enterButton.tintColor = UIColor(named: "myOrange")
        
    }

    @IBAction func enterAction(_ sender: Any) {
        NetWorking.shared.getAllheroes(success: { allHeroes in
            let home = HomeViewController()
            
            self.navigationController?.pushViewController(home,
                                                     animated: true)
        }, failure: { error in
            print("Error")
        })
        
    }
}
