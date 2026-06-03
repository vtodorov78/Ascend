//
//  SelectedDayTaskList.swift
//  Ascend
//
//  Created by Vladimir Todorov on 3.06.26.
//

import SwiftUI

struct SelectedDayTaskListView: View {
    let selectedDate: Date
    let tasks: [ToDoTask]
    let onDelete: (ToDoTask) -> Void
    let onEdit: (ToDoTask) -> Void

    private var completedCount: Int {
        tasks.filter { $0.isCompleted }.count
    }

    private var selectedDayTitle: String {
        selectedDate.formatted(date: .abbreviated, time: .omitted)
    }

    var body: some View {
        List {
            Section {
                ForEach(tasks) { task in
                    TaskRow(toDoTask: task)
                        .contextMenu {
                            Button {
                                withAnimation {
                                    task.isCompleted.toggle()
                                }
                            } label: {
                                Label(task.isCompleted ? "Mark as incomplete" : "Complete",
                                    systemImage: task.isCompleted ? "circle" : "checkmark.circle")
                                .tint(.green)
                            }

                            Button {
                                onEdit(task)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                                    .tint(.accentLight)
                            }

                            Button(role: .destructive) {
                                onDelete(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .tint(.red)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                onDelete(task)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color("surfaceElevated"))
                }
            } header: {
                HStack {
                        Text("Completed \(completedCount) / \(tasks.count)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textPrimary)

                    Spacer()
                }
                .padding(.bottom)
            }
        }
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        .background(.backgroundPrimary)
        .overlay {
            if tasks.isEmpty {
                ContentUnavailableView(
                    "No tasks for this day",
                    systemImage: "calendar",
                    description: Text("Tasks you create for this date will appear here.")
                )
            }
        }
    }
}

#Preview {
    SelectedDayTaskListView(
        selectedDate: .now,
        tasks: [
            ToDoTask(title: "Finish calendar UI", time: .now),
            ToDoTask(title: "Study SwiftData", time: .now),
            ToDoTask(title: "Workout", time: .now)
        ],
        onDelete: { _ in },
        onEdit: { _ in }
    )
}
