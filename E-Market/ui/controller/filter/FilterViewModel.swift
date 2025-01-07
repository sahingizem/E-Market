//
//  FilterViewModel.swift
//  E-Market
//
//  Created by gizem on 8.01.2025.
//

import Foundation

class FilterViewModel {
    
    var brands: [String] = []
    var models: [String] = []

    var products: [Product] = []
    
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
                self.brands = Array(Set(products.map { $0.brand })) 
                self.models = Array(Set(products.map { $0.model }))
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
    
    
}
