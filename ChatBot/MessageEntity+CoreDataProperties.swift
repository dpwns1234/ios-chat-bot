//
//  Entity+CoreDataProperties.swift
//  ChatBot
//
//  Created by 김예준 on 1/31/24.
//
//

import Foundation
import CoreData


extension MessageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageEntity> {
        return NSFetchRequest<MessageEntity>(entityName: "MessageEntity")
    }

    @NSManaged public var message: String
    @NSManaged public var messageID: UUID
    @NSManaged public var sender: String
    @NSManaged public var relationship: ChatRoom?

}

extension MessageEntity : Identifiable {

}
