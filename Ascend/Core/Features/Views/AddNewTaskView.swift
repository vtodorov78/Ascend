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
    
    private var canCreateTask: Bool {
        !taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Title")
                        .font(.footnote)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 5)
                    
                    TextField("Enter a task title..", text: $taskTitle)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.sentences)
                        .padding(15)
                        .background(.surfaceElevated)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Date and Time")
                        .font(.footnote)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 5)
                    
                    
                    DatePicker("", selection: $taskTime, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding(15)
                        .tint(.accentLight)
                        .labelsHidden()
                }
                
                Spacer()
                
                Button() {
                    withAnimation {
                        addTodoTask()
                    }
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
                .disabled(!canCreateTask)
                .opacity(canCreateTask ? 1 : 0.5)
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
    private func addTodoTask() {
        let trimmedTitle = taskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else { return }
        
        let toDoTask = ToDoTask(title: trimmedTitle, time: taskTime, isCompleted: false)
        
        context.insert(toDoTask)
        dismiss()
    }
}

#Preview {
    AddNewTaskView()
}
