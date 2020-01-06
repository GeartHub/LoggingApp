//
//  StepMO+CoreDataProperties.swift
//  LoggingApp
//
//  Created by Geart Otten on 04/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//
//

import Foundation
import CoreData


extension StepMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StepMO> {
        return NSFetchRequest<StepMO>(entityName: "Step")
    }

    @NSManaged public var title: String?
    @NSManaged public var form: Set<FormMO>?
    @NSManaged public var question: Set<QuestionMO>?

}

// MARK: Generated accessors for form
extension StepMO {

    @objc(addFormObject:)
    @NSManaged public func addToForm(_ value: FormMO)

    @objc(removeFormObject:)
    @NSManaged public func removeFromForm(_ value: FormMO)

    @objc(addForm:)
    @NSManaged public func addToForm(_ values: NSSet)

    @objc(removeForm:)
    @NSManaged public func removeFromForm(_ values: NSSet)

}

// MARK: Generated accessors for question
extension StepMO {

    @objc(addQuestionObject:)
    @NSManaged public func addToQuestion(_ value: QuestionMO)

    @objc(removeQuestionObject:)
    @NSManaged public func removeFromQuestion(_ value: QuestionMO)

    @objc(addQuestion:)
    @NSManaged public func addToQuestion(_ values: NSSet)

    @objc(removeQuestion:)
    @NSManaged public func removeFromQuestion(_ values: NSSet)

}
