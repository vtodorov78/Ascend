//
//  TaskRow.swift
//  Ascend
//
//  Created by Vladimir Todorov on 1.05.26.
//

import SwiftUI

struct TaskRow: View {
    let toDoTask: ToDoTask
    
    var body: some View {
        HStack(spacing: 16) {
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 3.6, height: 48)
                .foregroundStyle(.accentLight)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(toDoTask.title)
                    .font(.headline)
                    .foregroundStyle(.textPrimary)
                    .strikethrough(toDoTask.isCompleted, pattern: .solid)
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.textSecondary)
                    
                    Text(toDoTask.time, style: .time)
                        .font(.subheadline)
                        .foregroundStyle(.textSecondary)
                        .strikethrough(toDoTask.isCompleted, pattern: .solid)
                }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    toDoTask.isCompleted.toggle()
                }
            } label: {
                Image(systemName: toDoTask.isCompleted ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.accentLight)
            }
            .buttonStyle(.plain)
        }
        .background(.surfaceElevated)
    }
}

#Preview {
    TaskRow(toDoTask: ToDoTask(title: "iOS coding", time: .now, isCompleted: false))
}
