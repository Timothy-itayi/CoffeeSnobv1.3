//
//  Item.swift
//  Cafe-Project
//
//  Created by Gracie Sharkey on 02/04/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
