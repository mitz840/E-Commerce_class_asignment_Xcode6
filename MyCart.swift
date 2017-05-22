//
//  MyCart.swift
//  
//
//  Created by Mitesh Patel on 2016-04-02.
//
//

import Foundation
import CoreData

class MyCart: NSManagedObject {

    @NSManaged var user: String
    @NSManaged var picture: NSData
    @NSManaged var price: NSNumber
    @NSManaged var model: String

}
