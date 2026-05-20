//
//  AddNewTaskView.swift
//  Ascend
//
//  Created by Vladimir Todorov on 11.05.26.
//

import SwiftUI
import SwiftData

struct AddNewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var taskTitle: String = ""
    @State private var taskTime: Date = .init()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Title")
                        .font(.footnote)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 5)
                    
                    TextField("Enter a task title..", text: $taskTitle)
                        .padding(15)
                        .background(.surfaceElevated)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Date and Time")
                        .font(.footnote)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 5)
                    
                    
                    DatePicker("", selection: $taskTime)
                        .datePickerStyle(.compact)
                        .padding(15)
                        .tint(.accentLight)
                        .labelsHidden()
                }
                
                Spacer()
                
                Button() {
                    addTodoTask()
                } label: {
                    Text("Create Task")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textPrimary)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentLight)
                .disabled(taskTitle == "")
                .opacity(taskTitle == "" ? 0.5 : 1)
                .navigationTitle("New Task")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundStyle(.accentLight)
                    }
                }
            }
            .padding()
        }
    }
}

private extension AddNewTaskView {
    func addTodoTask() {
        let toDoTask = ToDoTask(title: taskTitle, time: taskTime, isCompleted: false)
        
        context.insert(toDoTask)
        dismiss()
    }
}

#Preview {
    AddNewTaskView()
    
}
