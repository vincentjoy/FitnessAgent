//
//  DetailView.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 24/05/25.
//

import SwiftUI

struct DetailView: View {
    
    var user: User
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack {
            Text("User Detail View")
                .font(.title)
                .padding()
            
            Text("Name: \(user.name)")
                .font(.headline)
                .padding()
            
            NavigationLink("Go to next view", value: "NextView")
                .padding()
                .background(.green)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .navigationTitle("\(user.name)'s Details")
        .navigationDestination(for: String.self) { value in
            if value == "NextView" {
                
            }
        }
    }
}

#Preview {
    DetailView(user: User.init(name: "Vincent", age: 35), navigationPath: .constant(NavigationPath()))
}
