//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var detailstable: UITableView!
    
    var model: HeroeData
    
    init(model: HeroeData) {
        self.model = model
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncModel()
        
        heroName.textColor = UIColor(named: "myRed")
        heroImage.contentMode = .scaleAspectFill
        heroImage.layer.cornerRadius = 20
        
        self.navigationController?.navigationBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .white
        view.backgroundColor = UIColor(named: "falseBlack")
        heroDescription.textColor = UIColor(named: "myRedLow")
        
        
        detailstable.backgroundColor = UIColor.clear
        detailstable.backgroundView = UIView.init(frame: CGRect.zero)
        detailstable.dataSource = self
        detailstable.delegate = self
    }
    
    func syncModel() {
        heroName.text = model.name
        if model.description == "" {
            heroDescription.text = "Sin descripción disponible"
        } else {
            heroDescription.text = model.description
        }
        let imageUrl = URL(string: model.thumbnail.ThumbnailComplete())
        
        NetWorking.shared.requestImage(url: imageUrl) { image in
            self.heroImage.image = image
        } failure: { error in
            RunLoop.main.perform {
                self.heroImage.image = UIImage(named: "Logo")
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Comics"
        }
        if section == 1 {
            return "Series"
        }
        if section == 2 {
            return "Stories"
        }
       return "Events"
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return model.comics.returned
        }
        if section == 1 {
            return model.series.returned
        }
        if section == 2 {
            return model.stories.returned
        }
        return model.events.returned
    }
  
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = UITableViewCell(style: .default,
                                         reuseIdentifier: "detailsCell")
        detailCell.textLabel?.textColor = UIColor(named: "myOrange")
        detailCell.backgroundColor = UIColor.clear
        detailCell.backgroundView = UIView.init(frame: CGRect.zero)
        if indexPath.section == 0 {
            detailCell.textLabel?.text = model.comics.items[indexPath.row].name
            return detailCell
        }
        if indexPath.section  == 1 {
            detailCell.textLabel?.text = model.series.items[indexPath.row].name
            return detailCell
        }
        if indexPath.section == 2 {
            detailCell.textLabel?.text = model.stories.items[indexPath.row].name
            return detailCell
        }
         detailCell.textLabel?.text = model.events.items[indexPath.row].name
        return detailCell
          
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(named: "myOrangeStrong")
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
}

extension DetailViewController: UITableViewDelegate {
   
}


