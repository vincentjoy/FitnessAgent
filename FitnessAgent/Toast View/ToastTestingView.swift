//
//  ToastTestingView.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

struct ToastTestingView: View {
    
    @Environment(\.showToast) private var showToast
    
    var body: some View {
        VStack {
            Button("Success") {
                showToast(.success("Succesful Action"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ToastTestingView()
        .withToast()
}
