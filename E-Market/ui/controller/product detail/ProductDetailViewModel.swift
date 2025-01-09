//
//  ProductDetailViewModel.swift
//  E-Market
//
//  Created by gizem on 8.01.2025.
//

import Foundation

class ProductDetailViewModel {
    
    /*
     func addToCart(product: Product) {
     CoreDataManager.shared.addItem(product)
     }*/
    
    func addToCart(product: Product, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            let success = CoreDataManager.shared.addItem(product)
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
