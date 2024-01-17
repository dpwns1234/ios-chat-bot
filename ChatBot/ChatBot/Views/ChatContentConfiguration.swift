//
//  ChatContentConfiguration.swift
//  ChatBot
//
//  Created by Wonji Ha on 1/16/24.
//

import UIKit

struct ChatContentConfiguration: UIContentConfiguration {
    var content: String?
    
    func makeContentView() -> UIView & UIContentView {
        return ChatContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}