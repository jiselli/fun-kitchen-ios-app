//
//  RecipeViewController.swift
//  fun kitchen
//
//  Created by Administrador on 10/06/24.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    var recipe: Recipe?
    @IBOutlet weak var recipeTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        self.recipeTableView.dataSource = self
        self.recipeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell-ingredients")
        self.recipeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell-preparations")
        configure()
    }
    
    @IBAction func close(_ sender: Any) {
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
        } else if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupImageView() {
        favoriteImageView.isUserInteractionEnabled = true
         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        favoriteImageView.addGestureRecognizer(tapGestureRecognizer)
     }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if let isFavorite = recipe?.favorite {
            recipe?.favorite = !isFavorite
            
            if let recipe = recipe {
                var allRevenuesFavorite: [Recipe] = FavoriteRecipe.shared.getFavorites() ?? []
                
                if isFavorite {
                    allRevenuesFavorite = allRevenuesFavorite.filter { $0.idRecipe != recipe.idRecipe }
                } else {
                    allRevenuesFavorite.append(recipe)
                }
                FavoriteRecipe.shared.updateFavorites(revenues: allRevenuesFavorite)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFavorites"), object: nil)
            }
        } else {
            recipe?.favorite = true
        }
        reloadFavorite()
    }
    
    func reloadFavorite() {
        if let isFavorite = recipe?.favorite {
                favoriteImageView.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            } else {
                favoriteImageView.image = UIImage(systemName: "heart")
            }
    }
    
    func configure() {
        if (recipe == nil) {
            return
        }
        reloadFavorite()
        imageView.layer.cornerRadius = 16
        titleLabel.text = recipe?.name
        subtitleLabel.text = recipe?.description
        if let systemImageName = recipe?.systemImageName {
                imageView.image = UIImage(named: systemImageName)
              } else {
                  imageView.image = nil
              }
    }
}

extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recipe?.ingredients.count ?? 0
            
        } else {
            return recipe?.preparationsMode.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Ingredientes"
            } else {
                return "Passos de preparação"
            }
        }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell-ingredients", for: indexPath)
           let ingredient = recipe?.ingredients[indexPath.row]
           cell.textLabel?.text = ingredient?.name
           cell.detailTextLabel?.text = ingredient?.quantity
           return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell-instructions", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row + 1).  \(recipe?.preparationsMode[indexPath.row])"
            return cell
        }
    }
}
