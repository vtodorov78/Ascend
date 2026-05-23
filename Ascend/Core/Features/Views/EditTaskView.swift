//
//  EditTaskView.swift
//  Ascend
//
//  Created by Vladimir Todorov on 22.05.26.
//

import SwiftUI
import SwiftData

struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let toDoTask: ToDoTask
    
    @State private var editedTitle: String
    @State private var editedTime: Date
    
    init(toDoTask: ToDoTask) {
        self.toDoTask = toDoTask
        _editedTitle = State(initialValue: toDoTask.title)
        _editedTime = State(initialValue: toDoTask.time)
    }
    
    private var canCreateTask: Bool {
        !toDoTask.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Title")
                        .font(.footnote)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 5)
                    
                    TextField("Enter a task title..", text: $editedTitle)
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
                    
                    
                    DatePicker("", selection: $editedTime, in: min(toDoTask.time, Date())..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding(15)
                        .tint(.accentLight)
                        .labelsHidden()
                }
                
                Spacer()
                
                Button {
                    updateTask()
                } label: {
                    Text("Update Task")
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
                .navigationTitle("Edit Task")
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

extension EditTaskView {
    func updateTask() {
        let trimmedTitle = editedTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else { return }
        
        toDoTask.title = trimmedTitle
        toDoTask.time = editedTime
        
        dismiss()
    }
}

#Preview {
    EditTaskView(toDoTask: ToDoTask(title: "Code", time: .now))
}
