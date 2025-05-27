//
//  ToastTestingView.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

struct ToastTestingView: View {
    
    @Environment(\.showToast) private var showToast
    @State private var settingsPresented: Bool = false
    
    var body: some View {
        VStack {
            Button("Success") {
                showToast(.success("Succesful Action"))
            }
            
            Button("Show Settings") {
                settingsPresented = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .sheet(isPresented: $settingsPresented) {
            SettingsScreen()
                .withToast()
        }
    }
}

#Preview {
    ToastTestingView()
        .withToast()
}
