//
//  CartManager.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var cartItems: [ProductItem] = [] {
            didSet {
                saveCartData()
            }
        }
    
    private init() {
        loadCartData()
    }
    
    func updateCartItemQuantity(at index: Int, quantity: Int) {
        guard index >= 0 && index < cartItems.count else { return }
        cartItems[index].quantity = quantity
        saveCartData()
    }
    
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
    
     func saveCartData() {
        let encodedData = try? JSONEncoder().encode(cartItems)
        UserDefaults.standard.set(encodedData, forKey: "cartItems")
    }
    
     func loadCartData() {
        if let data = UserDefaults.standard.data(forKey: "cartItems"),
           let decodedItems = try? JSONDecoder().decode([ProductItem].self, from: data) {
            cartItems = decodedItems
        }
    }
    
    func removeCartItem(at index: Int) {
        if index >= 0 && index < cartItems.count {
            cartItems.remove(at: index)
        }
    }
}
