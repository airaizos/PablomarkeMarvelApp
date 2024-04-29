//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var heroesCollection: UICollectionView!
    @IBOutlet weak var favouriteCollection: UICollectionView!
    
    @IBOutlet weak var tabBarDown: UITabBar!
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    //MARK: Model
    var modelLogic: ModelLogic
    let network: NetWorking
    
    init(modelLogic: ModelLogic = .shared, network: NetWorking = .shared){
        self.modelLogic = modelLogic
        self.network = network
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Modelos de prueba sin api
    let heroes = allHeroes2
   // let favouriteHeroes = favHeroes
    let appearance = UINavigationBarAppearance()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "myRed")
        //appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
        //                             .foregroundColor: UIColor.white]
        
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
        
        
        // Collection favourites
        
        if modelLogic.favourites.isEmpty {
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
        
        //Añadir a favoritos
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
              heroesCollection.addGestureRecognizer(longPressGesture)
        
        NotificationCenter.default.addObserver(forName: .favourites, object: nil, queue: .main) { [weak self] _ in
            self?.favouriteCollection.reloadData()
            
            if self?.modelLogic.favouritesCount ?? 0 >= 1 {
                self?.favouriteCollection.isHidden = false
                self?.topConstraint.constant = 177
            }
        }
        
        NotificationCenter.default.addObserver(forName: .heroes, object: nil, queue: .main) { [weak self] _ in
            self?.heroesCollection.reloadData()
        }
    }
    
    func toggleFavorite() {
        
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            if gestureRecognizer.state == .began {
                let point = gestureRecognizer.location(in: heroesCollection)
                if let indexPath = heroesCollection.indexPathForItem(at: point) {
                    let selectedItem = modelLogic.heroes[indexPath.item]
                    modelLogic.addFavourite(selectedItem)
                }
            }
        }
    deinit {
        NotificationCenter.default.removeObserver(self, name:.favourites, object: nil)
        NotificationCenter.default.removeObserver(self, name: .heroes, object: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == favouriteCollection {
            return modelLogic.favourites.count
        } else {
            return modelLogic.heroesCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == favouriteCollection {
            let favCell = favouriteCollection.dequeueReusableCell(withReuseIdentifier: "cellFav",
                                                                  for: indexPath) as! FavouriteCell
            let imageUrl = URL(string:modelLogic.favourites[indexPath.row].thumbnail.ThumbnailComplete())
            
            network.requestImage(url: imageUrl) { image in
                DispatchQueue.main.async {
                    favCell.favImage.image  = image
                }
            } failure: { error in
                RunLoop.main.perform {
                    favCell.favImage.image = UIImage(named: "Logo")
                }
            }
            
            
            favCell.favName.text = modelLogic.favourites[indexPath.row].name
            
            return favCell
        } else {
            let cell = heroesCollection.dequeueReusableCell(withReuseIdentifier: "HeroesCC",
                                                            for: indexPath) as! HeroesCollectionViewCell
            
            cell.HeroeName.text = modelLogic.heroes[indexPath.row].name
            let imageUrl = URL(string: modelLogic.heroes[indexPath.row].thumbnail.ThumbnailComplete())
            
            network.requestImage(url: imageUrl) { image in
                DispatchQueue.main.async {
                    cell.HeroeImage.image = image
                }
            } failure: { error in
                RunLoop.main.perform {
                    cell.HeroeImage.image  = UIImage(named: "Logo")
                }
            }
            
            cell.backgroundName.image = UIImage(named: "forNames")
            
            return cell
        }
    }
  
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == favouriteCollection {
          //ir a detalle
            let hero = modelLogic.favourites[indexPath.row]
            let detail = DetailViewController(model: hero)
            self.navigationController?.pushViewController(detail, animated: true)
            
        } else {
            network.getHeroe(id: modelLogic.heroes[indexPath.row].id!) { _ in
                let heroeDetailed = self.modelLogic.heroes[indexPath.row]
                let heroDetail = DetailViewController(model: heroeDetailed)
                
                self.navigationController?.pushViewController(heroDetail,
                                                              animated: true)
                
            } failure: { error in
                print("error")
            }
        }
    }
       
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            
            if maximumOffset - currentOffset <= 50 {
                self.modelLogic.fetchHeroes()
            }
        }
}

