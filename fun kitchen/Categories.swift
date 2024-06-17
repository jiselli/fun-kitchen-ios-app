//
//  Categories.swift
//  fun kitchen
//
//  Created by Administrador on 09/06/24.
//

import Foundation

class ItemCategories {
    let idCategory: Int
    let name: String
    let description: String
    let systemImageName: String
    
    init(idCategory: Int, name: String, description: String, systemImageName: String, isSelected: Bool = false) {
        self.idCategory = idCategory
        self.name = name
        self.description = description
        self.systemImageName = systemImageName
    }
}

class Categories {
    var allCategories: [ItemCategories] = [
        ItemCategories(idCategory: 1, name: "Carnes", description: "Carnes", systemImageName: "meat"),
        ItemCategories(idCategory: 2, name: "Lanches", description: "Lanches", systemImageName: "snacks"),
        ItemCategories(idCategory: 3, name: "Sobremesas", description: "Sobremesas", systemImageName: "dissert"),
    ]
    
    func addCategory(_ item: ItemCategories) {
        allCategories.append(item)
    }
    
    func removeCategory(from indexPath: IndexPath) {
        allCategories.remove(at: indexPath.row)
    }
    
    func getCategory(from indexPath: IndexPath) -> ItemCategories {
        allCategories[indexPath.row]
    }
}
