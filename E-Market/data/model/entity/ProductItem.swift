//
//  ProductItem.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation
import Foundation

struct ProductItem {
    let product: Product
    var quantity: Int
    
    init(product: Product, quantity: Int = 1) {
        self.product = product
        self.quantity = quantity
    }
}
