//
//  AddNewTaskView.swift
//  Ascend
//
//  Created by Vladimir Todorov on 11.05.26.
//

import SwiftUI

struct AddNewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var taskTitle: String = ""
    @State private var taskTime: Date = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.textSecondary)
                    .padding(.leading, 5)
                
                TextField("Enter a task title..", text: $taskTitle)
                    .padding(15)
                    .background(.surfaceElevated)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Task Date and Time")
                    .font(.caption)
                    .foregroundStyle(.textSecondary)
                    .padding(.leading, 5)
                
                
                DatePicker("", selection: $taskTime)
                    .datePickerStyle(.compact)
                    .padding(15)
                    .tint(.accentLight)
                    .labelsHidden()
            }
        }
        
        Spacer()
        
        Button() {
            dismiss()
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
        .padding()
        .disabled(taskTitle == "")
        .opacity(taskTitle == "" ? 0.5 : 1)
    }
}

#Preview {
    AddNewTaskView()
}
