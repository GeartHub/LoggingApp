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
    @NSManaged public var aircraft: Set<AircraftMO>?
    public var stepsArray: [StepMO] {
        let set = steps ?? []
        return set.sorted {
            $0.order < $1.order
        }
    }
}

// MARK: Generated accessors for aircraft
extension FormMO {

    @objc(addAircraftObject:)
    @NSManaged public func addToAircraft(_ value: AircraftMO)

    @objc(removeAircraftObject:)
    @NSManaged public func removeFromAircraft(_ value: AircraftMO)

    @objc(addAircraft:)
    @NSManaged public func addToAircraft(_ values: NSSet)

    @objc(removeAircraft:)
    @NSManaged public func removeFromAircraft(_ values: NSSet)

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
