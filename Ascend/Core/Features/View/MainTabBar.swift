//
//  MainTabBar.swift
//  Ascend
//
//  Created by Vladimir Todorov on 4.05.26.
//

import SwiftUI

enum TabIdentifier: Hashable {
    case home
}

struct MainTabBar: View {
    @State private var selectedTab: TabIdentifier = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: TabIdentifier.home) {
                HomeView()
            }
        }
        .tint(.accentLight)
    }
}

#Preview {
    MainTabBar()
}
