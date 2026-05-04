//
//  HomeView.swift
//  Ascend
//
//  Created by Vladimir Todorov on 1.05.26.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    
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
                    
                    Text("10")
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
                
                TasksList()
                
            }
            .background(.backgroundPrimary)
            .navigationBarTitle("Ascend")
            .searchable(text: $searchText, placement: .navigationBarDrawer)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
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
