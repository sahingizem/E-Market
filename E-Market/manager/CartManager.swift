//
//  CartManager.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    
    private(set) var cartItems: [ProductItem] = []
    
    private init() {}
    
    func addItem(_ product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            let newProductItem = ProductItem(product: product)
            cartItems.append(newProductItem)
        }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}
