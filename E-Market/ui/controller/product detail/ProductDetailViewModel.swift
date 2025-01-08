//
//  ProductDetailViewModel.swift
//  E-Market
//
//  Created by gizem on 8.01.2025.
//

import Foundation

class ProductDetailViewModel {
    
    
    func addToCart(product: Product) {
        CartManager.shared.addItem(product)
    }
    
}
