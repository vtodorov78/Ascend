//
//  StreakSliderView.swift
//  Ascend
//
//  Created by Vladimir Todorov on 2.05.26.
//

import SwiftUI

struct StreakSliderView: View {
    var body: some View {
        TabView {
            ForEach(1...3, id: \.self) { _ in
                CardDashboard()
            }
        }
        .frame(height: 220)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
}

#Preview {
    StreakSliderView()
}
