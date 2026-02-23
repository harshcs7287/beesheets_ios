//
//  Item.swift
//  beesheetsiOS
//
//  Created by user275733 on 2/13/26.
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
