//
//  CartManager.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    
    private(set) var cartItems: [Product] = []
    
    private init() {}
    
    func addItem(_ product: Product) {
        cartItems.append(product)
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}
