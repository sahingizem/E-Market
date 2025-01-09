//
//  CartViewModel.swift
//  E-Market
//
//  Created by gizem on 8.01.2025.
//

import Foundation

class CartViewModel {
    
    private(set) var cartItems: [CartItem] = []
    
    func loadCartItems() {
        
        cartItems = CoreDataManager.shared.cartItems
    }
    
    func calculateTotalPrice() -> Double {
        return cartItems.reduce(0) { total, item in
            if let price = Double(item.product.price) {
                return total + (price * Double(item.quantity))
            }
            return total
        }
    }
    
    func updateCartItemQuantity(at index: Int, quantity: Int) {
        guard index < cartItems.count else { return }
        cartItems[index].quantity = quantity
        CoreDataManager.shared.updateCartItemQuantity(at: index, quantity: quantity)
        
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
    
    func removeCartItem(at index: Int) {
        guard index < cartItems.count else { return }
        CoreDataManager.shared.removeCartItem(at: index)
        cartItems.remove(at: index)
        
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
    
    func clearCart() {
        CoreDataManager.shared.clearCart()
        cartItems.removeAll()
        
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
    
    func searchCartItem(by name: String) -> [CartItem] {
        return cartItems.filter { $0.product.name.lowercased().contains(name.lowercased()) }
    }
    
}

