//
//  ChatRoom+CoreDataProperties.swift
//  ChatBot
//
//  Created by 김예준 on 1/29/24.
//
//

import Foundation
import CoreData


extension ChatRoom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatRoom> {
        return NSFetchRequest<ChatRoom>(entityName: "ChatRoom")
    }

    @NSManaged public var roomID: UUID?
    @NSManaged public var created: Date?
    @NSManaged public var title: String?

}

extension ChatRoom : Identifiable {

}
