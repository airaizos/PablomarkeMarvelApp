//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 24/7/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
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
        heroName.textColor = UIColor(named: "myRedLow")
        view.backgroundColor = UIColor.black
        heroDescription.textColor = UIColor(named: "myRedLow")
        heroImage.layer.cornerRadius = 12
        detailstable.backgroundColor = UIColor.clear
        detailstable.backgroundView = UIView.init(frame: CGRect.zero)
        detailstable.dataSource = self
        detailstable.delegate = self
        
    }
    
    func syncModel() {
        heroName.text = model.name
        heroDescription.text = model.description
        let imageUrl = URL(string: model.thumbnail.ThumbnailComplete())
        heroImage.kf.setImage(with: imageUrl)
        
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
        detailCell.textLabel?.textColor = UIColor(named: "myRedLow")
        
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
}

extension DetailViewController: UITableViewDelegate {
   
}


