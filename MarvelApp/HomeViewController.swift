//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var favouriteCollection: UICollectionView!
    @IBOutlet weak var heroTable: UITableView!
    @IBOutlet weak var tabBarDown: UITabBar!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeView: UIView!
    
    let heroes: [String] = ["Lobezno", "Phoenix", "MsMarvel", "Pícara", "IronMan"]
    let favouriteHeroes: [String] = ["Phoenix", "MsMarvel",  "IronMan", "Lobezno", "Pícara"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.backgroundColor = UIColor(named: "myRed")
        
        homeImage.image = UIImage(named: "Universe")
        homeImage.contentMode = .scaleAspectFill
        
        tabBarDown.barTintColor = UIColor(named: "myRed")
        
        
        heroTable.dataSource = self
        heroTable.register(UINib(nibName: "HeroeCell", bundle: nil), forCellReuseIdentifier: "cellHeroe")
        heroTable.backgroundColor = UIColor.clear
        heroTable.backgroundView = UIView.init(frame: CGRect.zero)
        
        
        favouriteCollection.dataSource = self
        favouriteCollection.register(UINib(nibName: "CustomCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cellFav")
        favouriteCollection.backgroundColor = UIColor.clear
        favouriteCollection.backgroundView = UIView.init(frame: CGRect.zero)
        
        
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

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let favCell = favouriteCollection.dequeueReusableCell(withReuseIdentifier: "cellFav", for: indexPath) as! CustomCollectionCell
        
        favCell.favImage.image = UIImage(named: favouriteHeroes[indexPath.row])
        favCell.favLabel.text = favouriteHeroes[indexPath.row]
        
        
        
        
        return favCell
    }
    
    
}
