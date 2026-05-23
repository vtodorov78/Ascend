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
    
    @Bindable var toDoTask: ToDoTask
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Title")
                        .font(.footnote)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 5)
                    
                    TextField("Enter a task title..", text: $toDoTask.title)
                        .padding(15)
                        .background(.surfaceElevated)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Date and Time")
                        .font(.footnote)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 5)
                    
                    
                    DatePicker("", selection: $toDoTask.time)
                        .datePickerStyle(.compact)
                        .padding(15)
                        .tint(.accentLight)
                        .labelsHidden()
                }
                
                Spacer()
                
                Button {
                    dismiss()
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
                .disabled(toDoTask.title == "")
                .opacity(toDoTask.title == "" ? 0.5 : 1)
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

#Preview {
    EditTaskView(toDoTask: ToDoTask(title: "Code", time: .now))
}
