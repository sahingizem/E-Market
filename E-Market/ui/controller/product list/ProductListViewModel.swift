//
//  ProductListViewModel.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation

class ProductListViewModel {
    
    
    var products: [Product] = []
    private var favoriteProducts = [Product]()
    
    var filteredProducts: [Product] = []
    
    var numberOfProducts: Int {
        return filteredProducts.count
    }
    
    var filteredProductsCount: Int {
        return filteredProducts.count
    }
    
    func fetchProducts(completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.fetchProducts { result in
            switch result {
            case .success(let products):
                self.products = products
                self.filteredProducts = products
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchProducts(with searchText: String) -> [Product] {
        return products.filter { product in
            product.name.lowercased().contains(searchText)
        }
    }
    
    func product(at index: Int) -> Product? {
        guard index < filteredProducts.count else { return nil }
        return filteredProducts[index]
    }
    
    func addToCart(product: Product) {
        CartManager.shared.addItem(product)
    }
    
    func toggleFavorite(for product: Product) {
        if let index = favoriteProducts.firstIndex(where: { $0.id == product.id }) {
            favoriteProducts.remove(at: index)
        } else {
            favoriteProducts.append(product)
        }
    }
    
    func getFavorites() -> [Product] {
        return favoriteProducts
    }
    
    
    
}
