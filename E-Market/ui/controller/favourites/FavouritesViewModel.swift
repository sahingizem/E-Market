//
//  FavouritesViewModel.swift
//  E-Market
//
//  Created by gizem on 9.01.2025.
//

import Foundation

class FavouritesViewModel {
    
    var favoriteProducts: [Product] = []
    
    var onFavoritesUpdated: (() -> Void)?
    
    var numberOfFavorites: Int {
        return favoriteProducts.count
    }
    
    func favoriteProduct(at index: Int) -> Product {
        return favoriteProducts[index]
    }
    
    func updateFavorites(with products: [Product]) {
        self.favoriteProducts = products
        onFavoritesUpdated?()
    }
}
