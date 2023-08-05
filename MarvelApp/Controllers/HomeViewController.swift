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
    
    @IBOutlet weak var tabBarDown: UITabBar!
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var topView: UIView!
   
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
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
    let appearance = UINavigationBarAppearance()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]

        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        homeView.backgroundColor = UIColor(named: "falseBlack")
        topView.backgroundColor = UIColor(named: "myRed")
        self.navigationController?.navigationBar.tintColor = .black
        
        tabBarDown.unselectedItemTintColor = .black
        tabBarDown.tintColor = .white
        
        // Heroes collection
        heroesCollection.dataSource = self
        heroesCollection.delegate = self
        heroesCollection.register(UINib(nibName: "HeroesCollectionViewCell",
                                        bundle: nil), forCellWithReuseIdentifier: "HeroesCC")
        heroesCollection.backgroundColor = UIColor.clear
        heroesCollection.backgroundView = UIView.init(frame: CGRect.zero)
        heroesCollection.inputViewController?.tabBarItem.scrollEdgeAppearance 
        
        // Collection favourites
        
        if favouriteHeroes.isEmpty {
            favouriteCollection.isHidden = true
            topConstraint.constant = 24
            
        }
        favouriteCollection.dataSource = self
        favouriteCollection.delegate = self
        favouriteCollection.register(UINib(nibName: "FavouriteCell",
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
                                                                  for: indexPath) as! FavouriteCell
            favCell.favImage.image = favouriteHeroes[indexPath.row].image
            favCell.favName.text = favouriteHeroes[indexPath.row].name
            
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

