//
//  ProductListViewModel.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation

class ProductListViewModel {
    
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    var products: [Product] = []
    var searchFilteredProducts : [Product] = []
    private var favoriteProducts = [Product]()
    
    var filteredProducts: [Product] = []
    
    var numberOfProducts: Int {
        return filteredProducts.count
    }
    
    var filteredProductsCount: Int {
        return filteredProducts.count
    }
    
    func fetchProducts(completion: @escaping (Result<Void, Error>) -> Void) {
        networkManager.fetchProducts { result in
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
        coreDataManager.addItem(product)
    }
    
    func toggleFavorite(for product: Product) -> Product {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            var updatedProduct = products[index]
            updatedProduct.isFavourite?.toggle() 
            products[index] = updatedProduct
            return updatedProduct
        }
        return product
    }
    
    /*func toggleFavorite(for product: Product) {
     if let index = favoriteProducts.firstIndex(where: { $0.id == product.id }) {
     favoriteProducts.remove(at: index)
     } else {
     favoriteProducts.append(product)
     }
     }*/
    
    func getFavorites() -> [Product] {
        return favoriteProducts
    }
    
    func sortProducts(by option: String) {
        switch option {
        case "price":
            searchFilteredProducts.sort { $0.price < $1.price }
        case "rating":
            searchFilteredProducts.sort { $0.createdAt > $1.createdAt }
        default:
            break
        }
    }
    
    func filterProducts(by criterion: String) {
        searchFilteredProducts = products.filter { product in
            return product.brand.lowercased().contains(criterion.lowercased()) ||
            product.model.lowercased().contains(criterion.lowercased())
        }
    }
}
