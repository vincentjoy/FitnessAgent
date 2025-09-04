//
//  ActivityCard.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 22/05/25.
//

import SwiftUI

struct ActivityCard: View {
    
    var activity: Activity
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(activity.title)
                        Text(activity.subtitle)
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundStyle(Color.green)
                }
                
                Text(activity.amount)
                    .font(.title)
                    .bold()
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard(activity: .init(title: "Today's Steps", subtitle: "Goal 10,000", image: "figure.walk", tintColor: .green, amount: "6,131"))
}
