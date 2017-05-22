//
//  User.swift
//  
//
//  Created by Mitesh Patel on 2016-04-02.
//
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var username: String
    @NSManaged var picture: NSData

}
