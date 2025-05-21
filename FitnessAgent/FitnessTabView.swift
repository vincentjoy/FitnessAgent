//
//  FitnessTabView.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 21/05/25.
//

import SwiftUI

struct FitnessTabView: View {
    
    @State var selectedTab = "Home"
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .green
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                }
            HistoricDataView()
                .tag("History")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
        }
    }
}

#Preview {
    FitnessTabView()
}
