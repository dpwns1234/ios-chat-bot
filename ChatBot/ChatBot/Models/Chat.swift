//
//  Chat.swift
//  ChatBot
//
//  Created by 김예준 on 1/22/24.
//

import Foundation

struct Chat: Hashable {
    var messageID = UUID()
    let sender: Sender
    let message: String
    
    init(_ entity: MessageEntity) {
        messageID = entity.messageID
        message = entity.message
        sender = Sender(rawValue: entity.sender)!
    }
    
    init(sender: Sender, message: String) {
        self.sender = sender
        self.message = message
    }
}
