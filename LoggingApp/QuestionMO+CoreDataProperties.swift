//
//  QuestionMO+CoreDataProperties.swift
//  LoggingApp
//
//  Created by Geart Otten on 12/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionMO> {
        return NSFetchRequest<QuestionMO>(entityName: "Question")
    }

    @NSManaged public var options: Double
    @NSManaged public var order: Double
    @NSManaged public var particularities: String?
    @NSManaged public var title: String?
    @NSManaged public var step: Set<StepMO>?

}

// MARK: Generated accessors for step
extension QuestionMO {

    @objc(addStepObject:)
    @NSManaged public func addToStep(_ value: StepMO)

    @objc(removeStepObject:)
    @NSManaged public func removeFromStep(_ value: StepMO)

    @objc(addStep:)
    @NSManaged public func addToStep(_ values: NSSet)

    @objc(removeStep:)
    @NSManaged public func removeFromStep(_ values: NSSet)

}
