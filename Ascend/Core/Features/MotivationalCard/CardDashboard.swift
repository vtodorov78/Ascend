//
//  CardDashboard.swift
//  Ascend
//
//  Created by Vladimir Todorov on 1.05.26.
//

import SwiftUI

struct CardDashboard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340,height: 200)
                .foregroundStyle(.surfaceElevated)
            
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Thu, 30 Jun 2026")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.accentLight)
                    
                    Spacer()
                    
                    Image(systemName: "flame.fill")
                        .resizable()
                        .frame(width: 30, height: 32)
                        .foregroundStyle(.red)
                }
               
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("3 day streak!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.textPrimary)
                    
                    Text("You have completed all your goals.")
                        .font(.callout)
                        .foregroundStyle(.textSecondary)
                    
                    Text("3 days in a row! You can do this!")
                        .font(.callout)
                        .foregroundStyle(.textSecondary)
                }
            }
            .padding(.leading, 48)
            .padding(.trailing, 48)
            .padding(.bottom, 22)
        }
    }
}

#Preview {
    CardDashboard()
}
