//
//  ChatRoom+CoreDataProperties.swift
//  ChatBot
//
//  Created by 김예준 on 1/30/24.
//
//

import Foundation
import CoreData


extension ChatRoom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatRoom> {
        return NSFetchRequest<ChatRoom>(entityName: "ChatRoom")
    }

    @NSManaged public var created: Date
    @NSManaged public var roomID: UUID
    @NSManaged public var title: String
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension ChatRoom {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: MessageEntity)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: MessageEntity)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension ChatRoom : Identifiable {

}
