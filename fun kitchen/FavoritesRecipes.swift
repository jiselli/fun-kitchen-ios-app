    //
    //  FavoritesRecipes.swift
    //  fun kitchen
    //
    //  Created by Administrador on 11/06/24.
    //
import Foundation

class FavoriteRecipe {
    static let shared = FavoriteRecipe()
    private let key: String = "revenues"
    var revenues: [Recipe]?

    private init() {
        self.revenues = []
        loadFavorites()
    }

    public func updateFavorites(revenues: [Recipe]?) {
        self.revenues = revenues
        saveFavorites()
    }

    public func getFavorites() -> [Recipe]? {
        return revenues
    }

    private func saveFavorites() {
        if let revenues = self.revenues {
            let encodedData = try? JSONEncoder().encode(revenues)
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }

    private func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: key) {
            if let loadedRevenues = try? JSONDecoder().decode([Recipe].self, from: savedData) {
                self.revenues = loadedRevenues
            }
        }
    }
}
