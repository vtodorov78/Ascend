//
//  Task.swift
//  Ascend
//
//  Created by Vladimir Todorov on 4.05.26.
//

import Foundation
import SwiftData

@Model
final class ToDoTask {
    var id: String = UUID().uuidString
    var title: String
    var time: Date
    var isCompleted: Bool
    
    init(title: String, time: Date, isCompleted: Bool = false) {
        self.title = title
        self.time = time
        self.isCompleted = isCompleted
    }
}
