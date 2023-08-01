//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var heroesCollection: UICollectionView!
    @IBOutlet weak var favouriteCollection: UICollectionView!
    @IBOutlet weak var heroTable: UITableView!
    @IBOutlet weak var tabBarDown: UITabBar!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeView: UIView!
    
    
    //MARK: Model
    var model: Data
    
    init(_ model: Data){
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Modelos de prueba sin api
    let heroes = allHeroes2
    let favouriteHeroes = favHeroes
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.backgroundColor = UIColor(named: "myRed")
        
        homeImage.image = UIImage(named: "Universe")
        homeImage.contentMode = .scaleAspectFill
        
        tabBarDown.barTintColor = UIColor(named: "myRed")
        
        // Heroes collection
        heroesCollection.dataSource = self
        heroesCollection.delegate = self
        heroesCollection.register(UINib(nibName: "HeroesCollectionViewCell",
                                        bundle: nil), forCellWithReuseIdentifier: "HeroesCC")
        
        heroesCollection.backgroundColor = UIColor.clear
        heroesCollection.backgroundView = UIView.init(frame: CGRect.zero)
        
        // Collection favourite
        favouriteCollection.dataSource = self
        favouriteCollection.delegate = self
        favouriteCollection.register(UINib(nibName: "CustomCollectionCell",
                                           bundle: nil),
                                     forCellWithReuseIdentifier: "cellFav")
        favouriteCollection.backgroundColor = UIColor.clear
        favouriteCollection.backgroundView = UIView.init(frame: CGRect.zero)
    
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == favouriteCollection {
            return favouriteHeroes.count
        } else {
            return model.count
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == favouriteCollection {
            let favCell = favouriteCollection.dequeueReusableCell(withReuseIdentifier: "cellFav",
                                                                  for: indexPath) as! CustomCollectionCell
            favCell.favImage.image = favouriteHeroes[indexPath.row].image
            favCell.favLabel.text = favouriteHeroes[indexPath.row].name
            
            return favCell
        } else {
            let cell = heroesCollection.dequeueReusableCell(withReuseIdentifier: "HeroesCC",
                                                     for: indexPath) as! HeroesCollectionViewCell
            
            cell.HeroeName.text = model.results![indexPath.row].name
            let imageUrl = URL(string: model.results![indexPath.row].thumbnail.ThumbnailComplete())
            cell.HeroeImage?.kf.setImage(with: imageUrl)
            cell.backgroundName.image = UIImage(named: "forNames")
            
            return cell
    }
        
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        NetWorking.shared.getHeroe(id: model.results![indexPath.row].id!) { heroe in
            let heroeDetailed = self.model.results![indexPath.row]
            let heroDetail = DetailViewController(model: heroeDetailed)
            
            self.navigationController?.pushViewController(heroDetail,
                                                          animated: true)
            
        } failure: { error in
            print("error")
        }
    }
}
