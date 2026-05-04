//
//  TaskRow.swift
//  Ascend
//
//  Created by Vladimir Todorov on 1.05.26.
//

import SwiftUI

struct TaskRow: View {
    var body: some View {
        HStack(spacing: 16) {
           
           RoundedRectangle(cornerRadius: 16)
                .frame(width: 3.6, height: 48)
                .foregroundStyle(.accentLight)
        
           VStack(alignment: .leading, spacing: 10) {
               Text("Walk the Dog")
                   .font(.headline)
                   .foregroundStyle(.textPrimary)
               
               HStack {
                   Image(systemName: "clock.fill")
                       .foregroundStyle(.textSecondary)
                   
                   Text("From 16:00-16:30")
                       .font(.subheadline)
                       .foregroundStyle(.textSecondary)
               }
           }
           
           Spacer()
           
           Image(systemName: "checkmark.circle")
               .resizable()
               .frame(width: 40, height: 40)
               .foregroundStyle(.accentLight)
       }
    }
}

#Preview {
    TaskRow()
}
