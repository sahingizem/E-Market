//
//  CartItemEntity+CoreDataProperties.swift
//  
//
//  Created by gizem on 9.01.2025.
//
//

import Foundation
import CoreData


public extension CartItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItemEntity> {
        return NSFetchRequest<CartItemEntity>(entityName: "CartItemEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int64

}
