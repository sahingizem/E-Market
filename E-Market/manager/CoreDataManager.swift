//
//  CartManager.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var cartItems: [CartItem] = [] {
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
    
    func addItem(_ product: Product) -> Bool {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            let newCartItem = CartItem(product: product, quantity: 1)
            cartItems.append(newCartItem)
        }
        return true
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
    
    func saveCartData() {
        let context = persistentContainer.viewContext
        
        let productItems = cartItems.map { $0.toProductItem() }
        let encodedData = try? JSONEncoder().encode(productItems)
        UserDefaults.standard.set(encodedData, forKey: "cartItems")
    }
    
    func loadCartData() {
        if let data = UserDefaults.standard.data(forKey: "cartItems"),
           let decodedItems = try? JSONDecoder().decode([ProductItem].self, from: data) {
            cartItems = decodedItems.map { $0.toCartItem() }
        }
    }
    
    func removeCartItem(at index: Int) {
        if index >= 0 && index < cartItems.count {
            cartItems.remove(at: index)
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "E_Market")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
}
