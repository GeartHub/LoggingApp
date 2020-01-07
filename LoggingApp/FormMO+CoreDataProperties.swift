//
//  FormMO+CoreDataProperties.swift
//  LoggingApp
//
//  Created by Geart Otten on 07/01/2020.
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
    @NSManaged public var steps: Set<StepMO>?
    @NSManaged public var aircraft: Aircraft?
    public var stepsArray: [StepMO] {
        let set = steps ?? []
        return set.sorted {
            $0.order < $1.order
        }
    }
}

// MARK: Generated accessors for steps
extension FormMO {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: StepMO)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: StepMO)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}
