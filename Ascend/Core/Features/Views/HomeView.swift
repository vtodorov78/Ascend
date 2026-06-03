//
//  HomeView.swift
//  Ascend
//
//  Created by Vladimir Todorov on 1.05.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var searchText = ""
    @State private var showingAdd = false
    @State private var taskToEdit: ToDoTask?
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \ToDoTask.time, order: .forward) private var tasks: [ToDoTask]
    
    var todayTasks: [ToDoTask] {
        tasks.filter {
            Calendar.current.isDate($0.time, inSameDayAs: Date())
        }
    }
    
    var remainingTasksCount: Int {
        todayTasks.filter { !$0.isCompleted }.count
    }
    
    var filteredTasks: [ToDoTask] {
        guard !searchText.isEmpty else { return todayTasks }
        
        return todayTasks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(filteredTasks) { task in
                        TaskRow(toDoTask: task)
                            .contextMenu {
                                Button {
                                    withAnimation {
                                        task.isCompleted.toggle()
                                    }
                                } label: {
                                    Label(task.isCompleted ? "Mark as incomplete" : "Complete", systemImage: task.isCompleted ? "circle" : "checkmark.circle")
                                        .tint(.green)
                                }
                                    
                                Button {
                                    withAnimation {
                                        taskToEdit = task
                                    }
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                        .tint(.accentLight)
                                }
                                
                                Button(role: .destructive) {
                                    withAnimation {
                                        deleteToDoTask(task)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .tint(.red)
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        deleteToDoTask(task)
                                    }
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
                        Text("Today's tasks")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textPrimary)
                        
                        Spacer()
                        
                        Text("\(remainingTasksCount)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(width: 38, height: 38)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(remainingTasksCount > 0 ? .red : .green, lineWidth: 3)
                            }
                            .foregroundStyle(remainingTasksCount > 0 ? .red : .green)
                    }
                    .padding(.bottom)
                }
            }
            .listRowSpacing(20)
            .scrollContentBackground(.hidden)
            .scrollDismissesKeyboard(.immediately)
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .overlay {
                if tasks.isEmpty {
                    ContentUnavailableView("No tasks yet", systemImage: "checklist", description: Text("Tap the plus button to add your first task."))
                } else if filteredTasks.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
            .navigationTitle("Ascend")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .background(.backgroundPrimary)
            .sheet(isPresented: $showingAdd, content: {
                AddNewTaskView()
                    .padding(.top, 25)
                    .padding(.horizontal, 8)
                    .presentationDetents([.medium])
                    .presentationCornerRadius(30)
                
                    .presentationBackground(.surfaceCard)
            })
            .sheet(item: $taskToEdit) { task in
                EditTaskView(toDoTask: task)
                    .padding(.top, 25)
                    .padding(.horizontal, 8)
                    .presentationDetents([.medium])
                    .presentationCornerRadius(30)
                    .presentationBackground(.surfaceCard)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.accentLight)
                    }
                }
            }
        }
    }
}

extension HomeView {
    private func deleteToDoTask(_ task: ToDoTask) {
        context.delete(task)
    }
}


#Preview {
    HomeView()
}
