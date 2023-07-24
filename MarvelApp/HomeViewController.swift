//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var heroTable: UITableView!
    @IBOutlet weak var tabBarDown: UITabBar!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeView: UIView!
    
    let heroes: [String] = ["Lobezno", "Phoenix", "MsMarvel", "Pícara", "IronMan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.backgroundColor = UIColor.red
        
        homeImage.image = UIImage(named: "Universe")
        homeImage.contentMode = .scaleAspectFill
        
        tabBarDown.barTintColor = UIColor.red
        
        heroTable.dataSource = self
        heroTable.register(UINib(nibName: "HeroeCell", bundle: nil), forCellReuseIdentifier: "cellHeroe")
        
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroTable.dequeueReusableCell(withIdentifier: "cellHeroe", for: indexPath) as! HeroeCell
        
        cell.heroeName.text = heroes[indexPath.row]
        cell.heroeImage?.image = UIImage(named: heroes[indexPath.row])
        
        return cell
    }
   
    
}

