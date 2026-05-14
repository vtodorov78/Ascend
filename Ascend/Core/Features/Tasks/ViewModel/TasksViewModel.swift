//
//  TasksViewModel.swift
//  Ascend
//
//  Created by Vladimir Todorov on 14.05.26.
//

import Foundation

@Observable
class TasksViewModel {
    var tasks = [ToDoTask]()
    
    var remainingTasksCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        tasks =  [
            .init(title: "iOS Development", time: .now),
            .init(title: "Security Research", time: .now),
            .init(title: "MMA Workout", time: .now),
            .init(title: "Reading", time: .now)
        ]
    }
    
    func addTask(_ task: ToDoTask) {
        tasks.append(task)
    }
}
