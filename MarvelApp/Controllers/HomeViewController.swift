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
    
    let heroes = allHeroes
    let favouriteHeroes = favHeroes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.backgroundColor = UIColor(named: "myRed")
        
        homeImage.image = UIImage(named: "Universe")
        homeImage.contentMode = .scaleAspectFill
        
        tabBarDown.barTintColor = UIColor(named: "myRed")
        
        
        heroTable.dataSource = self
        heroTable.delegate = self
        heroTable.register(UINib(nibName: "HeroeCell", bundle: nil),
                           forCellReuseIdentifier: "cellHeroe")
        
        heroTable.backgroundColor = UIColor.clear
        heroTable.backgroundView = UIView.init(frame: CGRect.zero)
        
        
        favouriteCollection.dataSource = self
        favouriteCollection.delegate = self
        favouriteCollection.register(UINib(nibName: "CustomCollectionCell", bundle: nil),
                                     forCellWithReuseIdentifier: "cellFav")
        favouriteCollection.backgroundColor = UIColor.clear
        favouriteCollection.backgroundView = UIView.init(frame: CGRect.zero)
        
        
    }

}

extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = heroTable.dequeueReusableCell(withIdentifier: "cellHeroe",
                                                 for: indexPath) as! HeroeCell
        cell.heroeName.text = heroes[indexPath.row].name
        cell.heroeImage?.image =  heroes[indexPath.row].image
        
        return cell
        
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroeDetailed = allHeroes[indexPath.row]
        //let heroDetail = DetailViewController(model: heroeDetailed)
        
        
        print("\(heroeDetailed.name)")
       // navigationController?.pushViewController(heroDetail,
         //                                        animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return favouriteHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let favCell = favouriteCollection.dequeueReusableCell(withReuseIdentifier: "cellFav",
                                                              for: indexPath) as! CustomCollectionCell
        favCell.favImage.image = favouriteHeroes[indexPath.row].image
        favCell.favLabel.text = favouriteHeroes[indexPath.row].name
        
        return favCell
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let heroeDetailed = favHeroes[indexPath.row]
       // let heroDetail = DetailViewController(model: heroeDetailed)
        
        
        print("\(heroeDetailed.name)")
       // navigationController?.pushViewController(heroDetail,
        //                                         animated: true)
    }
}
