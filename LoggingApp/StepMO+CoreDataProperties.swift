//
//  StepMO+CoreDataProperties.swift
//  LoggingApp
//
//  Created by Geart Otten on 07/01/2020.
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
    @NSManaged public var order: Int32
    @NSManaged public var form: Set<FormMO>?
    @NSManaged public var questions: Set<QuestionMO>?
   
    public var questionsArray: [QuestionMO] {
        let set = questions ?? []
        return set.sorted {
            $0.order < $1.order
        }
    }
    
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

// MARK: Generated accessors for questions
extension StepMO {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: QuestionMO)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: QuestionMO)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
