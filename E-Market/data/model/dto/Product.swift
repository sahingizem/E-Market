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
    let isFavourite: Bool?
}

func sampleProducts() -> [Product] {
    
    return [
        Product(id: "1", name: "iPhone 14 Pro Max", price: "15000", description: "256GB, Silver", image: "https://example.com/image1.png", brand: "Apple", model: "model1", createdAt: "createDate1", isFavourite: true),
        
        Product(id: "2", name: "Samsung Galaxy S22", price: "12000", description: "128GB, Black", image: "https://example.com/image2.png", brand: "Samsung", model: "model2", createdAt: "createDate2", isFavourite: false),
        
        Product(id: "3", name: "Lenovo IdeaPad 3", price: "18000", description: "16GB RAM, 512GB SSD", image: "https://example.com/image3.png", brand: "Lenovo", model: "model3", createdAt: "createDate2", isFavourite: false)
    ]
    
}
