//
//  CategoriesViewController.swift
//  fun kitchen
//
//  Created by Administrador on 09/06/24.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var categories = Categories().allCategories
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollectionView.dataSource = self
    }    
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.label.text = categories[indexPath.row].name
        setImage(imageName: categories[indexPath.row].systemImageName, view: cell.view)
        cell.layer.cornerRadius = 16
        return cell
    }

    func setImage(imageName: String, view: UIView) {
        guard let image = UIImage(named: imageName) else {
            return
        }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        view.insertSubview(imageView, at: 0)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


