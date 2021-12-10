//
//  FastEntity+CoreDataProperties.swift
//  16ToGo Fasting Countdown
//
//  Created by Michael Schroeder

import UIKit
import CoreData


extension FastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FastEntity> {
        return NSFetchRequest<FastEntity>(entityName: "FastEntity")
    }

    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var timeFasted: Double

}

extension FastEntity : Identifiable {

}
