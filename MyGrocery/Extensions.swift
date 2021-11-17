//
//  Extensions.swift
//  MyGrocery
//
//  Created by Shibili Areekara on 17/11/21.
//

import Foundation
import CoreData

extension ShoppingList: ManagedObjectType  {
    static var entityName: String {
        return "ShoppingList"
    }
}
