import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var allRevenuesFavorite: [Recipe] = []

    var selectedRecipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: NSNotification.Name(rawValue: "reloadFavorites"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFavorites()
    }

    @objc func reloadFavorites() {
        self.allRevenuesFavorite = FavoriteRecipe.shared.getFavorites() ?? []
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFavorite" {
            if let recipeViewController = segue.destination as? RecipeViewController {
                recipeViewController.recipe = selectedRecipe
            }
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRevenuesFavorite.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell-favorite", for: indexPath)
        let content = allRevenuesFavorite[indexPath.row]

        cell.textLabel?.text = content.name
        cell.detailTextLabel?.text = content.description
        cell.imageView?.image = UIImage(named: content.systemImageName)
        cell.selectionStyle = .none
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = allRevenuesFavorite[indexPath.row]
        performSegue(withIdentifier: "toDetailFavorite", sender: nil)
    }
}
