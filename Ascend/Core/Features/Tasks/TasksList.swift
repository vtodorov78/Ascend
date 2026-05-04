//
//  TasksList.swift
//  Ascend
//
//  Created by Vladimir Todorov on 4.05.26.
//

import SwiftUI

struct TasksList: View {
    var body: some View {
        List {
            ForEach(1...10, id: \.self) { _ in
                TaskRow()
            }
            .listRowBackground(Color("surfaceCard"))
        }
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    TasksList()
}
