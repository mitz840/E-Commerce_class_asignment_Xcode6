//
//  Smartwatch.swift
//  
//
//  Created by Mitesh Patel on 2016-04-02.
//
//

import Foundation
import CoreData

class Smartwatch: NSManagedObject {

    @NSManaged var about: String
    @NSManaged var model: String
    @NSManaged var price: NSNumber
    @NSManaged var quantity: NSNumber
    @NSManaged var picture: NSData

}
