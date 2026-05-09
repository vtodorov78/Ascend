//
//  Task.swift
//  Ascend
//
//  Created by Vladimir Todorov on 4.05.26.
//

import Foundation

struct ToDoTask: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let time: Date
    var isCompleted: Bool = false
}
