//
//  HomeView.swift
//  Ascend
//
//  Created by Vladimir Todorov on 1.05.26.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    
    @State private var showingAdd = false
    
    @State private var tasks: [ToDoTask] = [
        ToDoTask(title: "Morning routine", time: .now),
        ToDoTask(title: "iOS Coding", time: .now),
        ToDoTask(title: "Security study", time: .now),
        ToDoTask(title: "Workout", time: .now),
        ToDoTask(title: "Read 15 pages", time: .now)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                StreakSliderView()
                
                HStack {
                    Text("Today's tasks")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textPrimary)
                    
                    Spacer()
                    
                    Text("\(tasks.count)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 38, height: 38)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.accentLight, lineWidth: 3)
                        }
                        .foregroundStyle(.accentLight)
                }
                .padding(.horizontal)
                .padding(.top)
                
                List {
                    ForEach(tasks) { task in
                        TaskRow(toDoTask: task)
                    }
                    .listRowBackground(Color("surfaceElevated"))
                }
                .listRowSpacing(20)
                .scrollContentBackground(.hidden)
                
            }
            .background(.backgroundPrimary)
            .sheet(isPresented: $showingAdd, content: {
                AddNewTaskView()
                    .padding(.top, 25)
                    .padding(.horizontal, 8)
                    .presentationDetents([.height(310)])
                    .presentationCornerRadius(30)
                    .presentationBackground(.surfaceCard)
            })
            .navigationBarTitle("Ascend")
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.accentLight)
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
