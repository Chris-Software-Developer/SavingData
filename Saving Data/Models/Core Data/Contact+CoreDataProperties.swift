//
//  Contact+CoreDataProperties.swift
//  Saving Data
//
//  Created by Christopher Smith on 11/11/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
