//
//  CartItemEntity+CoreDataClass.swift
//  
//
//  Created by gizem on 9.01.2025.
//
//

import Foundation
import CoreData

@objc(CartItemEntity)
public class CartItemEntity: NSManagedObject {
    class CartItemEntity: NSManagedObject {
        @NSManaged var productId: Int64
        @NSManaged var productName: String
        @NSManaged var productPrice: Double
        @NSManaged var quantity: Int64
        
        var totalPrice: Double {
            return Double(quantity) * productPrice
        }
}
