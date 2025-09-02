//
//  NavigationStackApp.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 24/05/25.
//

import SwiftUI

struct NavigationStackApp: View {
    
    @State private var navigationPath = NavigationPath()
    @State private var users = [
        User(name: "John Doe", age: 34),
        User(name: "Cobb Joe", age: 45),
        User(name: "Lena Queen", age: 26)
    ]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Navigation Stack")
                    .font(.title)
                    .padding()
                
                List(users) { user in
                    NavigationLink(value: user) {
                        Text(user.name)
                            .font(.headline)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                }
            }
            .navigationTitle("Users")
            
            .navigationDestination(for: User.self) { user in
                DetailView(user: user, navigationPath: $navigationPath)
            }
        }
    }
}

#Preview {
    NavigationStackApp()
}
