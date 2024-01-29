//
//  Entity+CoreDataProperties.swift
//  ChatBot
//
//  Created by 김예준 on 1/24/24.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var messageID: UUID?
    @NSManaged public var sender: String?
    @NSManaged public var message: String?

}

extension Entity : Identifiable {

}
