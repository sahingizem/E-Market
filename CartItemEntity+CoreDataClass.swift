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
    
    extension CartItemEntity {
        func toCartItem() -> CartItem {
            return CartItem(
                product: Product(id: Int(self.productId), name: self.productName, price: String(self.productPrice)),
                quantity: Int(self.quantity)
            )
        }
    }
    
    extension CartItem {
        func toEntity(context: NSManagedObjectContext) -> CartItemEntity {
            let entity = CartItemEntity(context: context)
            entity.productId = Int64(self.product.id)
            entity.productName = self.product.name
            entity.productPrice = Double(self.product.price) ?? 0.00
            entity.quantity = Int64(self.quantity)
            return entity
        }
    }
