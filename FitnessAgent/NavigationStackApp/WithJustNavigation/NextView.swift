//
//  NextView.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

struct NextView: View {
    
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack {
            Text("This is the Final View")
                .font(.title)
                .padding()
            
            Button("Go back to home") {
                navigationPath.removeLast(navigationPath.count)
            }
            .padding()
            .background(.red)
            .foregroundStyle(Color.white)
            .cornerRadius(8)
        }
        .navigationTitle("Next")
    }
}

#Preview {
    NextView(navigationPath: .constant(.init()))
}
