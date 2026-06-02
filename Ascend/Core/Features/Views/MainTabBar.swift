//
//  MainTabBar.swift
//  Ascend
//
//  Created by Vladimir Todorov on 4.05.26.
//

import SwiftUI

enum TabIdentifier: Hashable {
    case home
    case calendar
}

struct MainTabBar: View {
    @State private var selectedTab: TabIdentifier = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: TabIdentifier.home) {
                HomeView()
            }
            
            Tab("Calendar", systemImage: "calendar.badge.checkmark", value: TabIdentifier.calendar) {
                CalendarView()
            }
        }
        .tint(.accentLight)
    }
}

#Preview {
    MainTabBar()
}
