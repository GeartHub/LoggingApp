//
//  FormMO+CoreDataProperties.swift
//  LoggingApp
//
//  Created by Geart Otten on 04/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//
//

import Foundation
import CoreData


extension FormMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FormMO> {
        return NSFetchRequest<FormMO>(entityName: "Form")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var title: String?
    @NSManaged public var step: Set<StepMO>?

}

// MARK: Generated accessors for step
extension FormMO {

    @objc(addStepObject:)
    @NSManaged public func addToStep(_ value: StepMO)

    @objc(removeStepObject:)
    @NSManaged public func removeFromStep(_ value: StepMO)

    @objc(addStep:)
    @NSManaged public func addToStep(_ values: NSSet)

    @objc(removeStep:)
    @NSManaged public func removeFromStep(_ values: NSSet)

}
