//
//  SettingsScreen.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

struct SettingsScreen: View {
    
    @State private var isNotificationOn: Bool = true
    @State private var isDarkModeOn: Bool = false
    
    @Environment(\.showToast) private var showToast
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading) {
                            Text("John Wick")
                                .font(.headline)
                            Text("johnwick@hightable.com")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $isNotificationOn)
                    Toggle("Dark Mode", isOn: $isDarkModeOn)
                }
                
                Section {
                    Button(role: .destructive) {
                        showToast(.info("You are signed out"))
                    } label: {
                        Text("Sign Out")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }

                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
        .withToast()
}
