//
//  Revenues.swift
//  fun kitchen
//
//  Created by Administrador on 09/06/24.
//

import Foundation
class Ingredient : Codable {
    let name: String
    let quantity: String
    
    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
    }
}

class Recipe : Codable {
    let idRecipe: Int
    let categoryId:Int
    let name: String
    let description: String
    let systemImageName: String
    let ingredients: [Ingredient]
    let preparationsMode: [String]
    var favorite: Bool = false
    
    init(idRecipe: Int, categoryId: Int, name: String, description: String, systemImageName: String, ingredients: [Ingredient], preparationsMode: [String], favorite: Bool) {
        self.idRecipe = idRecipe
        self.categoryId = categoryId
        self.name = name
        self.description = description
        self.systemImageName = systemImageName
        self.ingredients = ingredients
        self.preparationsMode = preparationsMode
        self.favorite = favorite
    }
}

class Revenues {
    var allRevenues: [Recipe] = [
        Recipe(
           idRecipe: 1,
           categoryId: 2,
           name: "Bolinho de Chuva",
           description: "Bolinhos de trigo fritos",
           systemImageName: "bolinhoChuva",
           ingredients: [
               Ingredient(name: "Trigo", quantity: "3 Xicaras"),
               Ingredient(name: "Chocolate em Pó", quantity: "1 Xicara")
           ],
           preparationsMode: [
               "Untar a assadeira",
               "Bater o trigo com leite",
               "Adicionar manteiga"
           ],
           favorite: false
       ),
        Recipe(idRecipe: 2, categoryId: 2, name: "Tapioca", description: "Massa leve feita de farinha de mandioca", systemImageName: "tapioca", ingredients: [], preparationsMode: [], favorite: false),
        Recipe(idRecipe: 3, categoryId: 2, name: "Bolo de Milho", description: "Bolo feito de milho verde", systemImageName: "boloMilho", ingredients: [], preparationsMode: [], favorite: false)
    ]
    
    func addRecipe(_ recipe: Recipe) {
        allRevenues.append(recipe)
    }
    
    func removeRecipe(from indexPath: IndexPath) {
        allRevenues.remove(at: indexPath.row)
    }
    
    func getRecipe(from indexPath: IndexPath) -> Recipe {
        allRevenues[indexPath.row]
    }
}
