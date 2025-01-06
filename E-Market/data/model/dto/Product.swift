//
//  Product.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation

struct Product: Codable {
    
    let id: String
    let name: String
    let price: String
    let description: String
    let image: String
    let brand: String
    let model: String
    let createdAt: String
    
}

extension Product {
    static var `default`: Product {
        return Product(id: "", name: "", price: "", description: "", image: "", brand: "", model: "", createdAt: "")
    }
}
