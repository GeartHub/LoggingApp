//
//  Aircraft+CoreDataProperties.swift
//  LoggingApp
//
//  Created by Geart Otten on 07/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//
//

import Foundation
import CoreData


extension Aircraft {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aircraft> {
        return NSFetchRequest<Aircraft>(entityName: "Aircraft")
    }

    @NSManaged public var type: String?
    @NSManaged public var serialnumber: String?
    @NSManaged public var forms: Set<FormMO>?

}

// MARK: Generated accessors for forms
extension Aircraft {

    @objc(addFormsObject:)
    @NSManaged public func addToForms(_ value: FormMO)

    @objc(removeFormsObject:)
    @NSManaged public func removeFromForms(_ value: FormMO)

    @objc(addForms:)
    @NSManaged public func addToForms(_ values: NSSet)

    @objc(removeForms:)
    @NSManaged public func removeFromForms(_ values: NSSet)

}
