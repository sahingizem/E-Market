//
//  ProductListViewModel.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation


class ProductListViewModel {
    private var products: [Product] = []
    
    var numberOfProducts: Int {
        products.count
    }
    
    func fetchProducts(completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.fetchProducts { result in
            switch result {
            case .success(let products):
                self.products = products
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func product(at index: Int) -> Product? {
        guard index < products.count else { return nil }
        return products[index]
    }
}
