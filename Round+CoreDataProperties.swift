//
//  Round+CoreDataProperties.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/14/22.
//
//

import Foundation
import CoreData


extension Round {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Round> {
        return NSFetchRequest<Round>(entityName: "Round")
    }

    @NSManaged public var elements: Int16
    @NSManaged public var level: Int16
    @NSManaged public var time: Int32

}

extension Round : Identifiable {

}
