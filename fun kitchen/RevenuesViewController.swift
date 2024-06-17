//
//  RevenuesViewController.swift
//  fun kitchen
//
//  Created by Administrador on 09/06/24.
//

import UIKit

class RevenuesViewController: UIViewController {
    
    let revenues = Revenues()
    var selectedRecipe: Recipe?

    @IBOutlet weak var revenuesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revenuesTableView.dataSource = self
        self.revenuesTableView.delegate = self
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toDetailRecipe" {
               if let recipeViewController = segue.destination as? RecipeViewController {
                   recipeViewController.recipe = selectedRecipe
               }
           }
       }
}


extension RevenuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revenues.allRevenues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell-identifier", for: indexPath)
        let content = revenues.getRecipe(from: indexPath)

        cell.textLabel?.text = content.name
        cell.detailTextLabel?.text = content.description
        cell.imageView?.image = UIImage(named: content.systemImageName)
        cell.selectionStyle = .none
        return cell
    }
}

extension RevenuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = revenues.getRecipe(from: indexPath)
        performSegue(withIdentifier: "toDetailRecipe", sender: nil)
    }
}
