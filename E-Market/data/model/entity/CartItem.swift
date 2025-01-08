//
//  CartItem.swift
//  E-Market
//
//  Created by gizem on 9.01.2025.
//

import Foundation
import CoreData

struct CartItem {
    let product: Product
    var quantity: Int
    
    var totalPrice: Double {
        return Double(quantity) * (Double(product.price) ?? 0.00)
    }
}

/*extension CartItem {
    func toProductItem() -> ProductItem {
        return ProductItem(product: self.product, quantity: self.quantity)
    }
}*/

/*struct CartItem : Codable {
 let product: Product
 var quantity: Int
 
 init(product: Product, quantity: Int = 1) {
 self.product = product
 self.quantity = quantity
 }
 }
 */
