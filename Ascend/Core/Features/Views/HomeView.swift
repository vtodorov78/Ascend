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
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \ToDoTask.time, order: .forward) private var tasks: [ToDoTask]
    
    var remainingTasksCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    var filteredTasks: [ToDoTask] {
        guard !searchText.isEmpty else { return tasks }
        return tasks.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        ForEach(filteredTasks) { task in
                            TaskRow(toDoTask: task)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            deleteToDoTask(task)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                            .tint(.red)
                                    }
                                } preview: {
                                    TaskRow(toDoTask: task)
                                        .frame(width: 340)
                                        .padding()
                                        .background(.surfaceElevated)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
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
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.textPrimary)
                            
                            Spacer()
                            
                            Text("\(remainingTasksCount)")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .frame(width: 38, height: 38)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.accentLight, lineWidth: 3)
                                }
                                .foregroundStyle(.accentLight)
                        }
                        .padding(.bottom)
                    }
                }
                .listRowSpacing(20)
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.immediately)
                .searchable(text: $searchText, placement: .navigationBarDrawer)
            }
            .navigationTitle("Ascend")
            .background(.backgroundPrimary)
            .sheet(isPresented: $showingAdd, content: {
                AddNewTaskView()
                    .padding(.top, 25)
                    .padding(.horizontal, 8)
                    .presentationDetents([.medium])
                    .presentationCornerRadius(30)
                    .presentationBackground(.surfaceCard)
            })
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
    func deleteToDoTask(_ task: ToDoTask) {
        context.delete(task)
    }
}


#Preview {
    HomeView()
}
