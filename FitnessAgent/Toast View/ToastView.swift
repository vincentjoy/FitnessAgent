//
//  ToastView.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

struct ToastView: View {
    
    let type: ToastType
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            type.icon
                .foregroundStyle(.white)
            Text(type.message)
                .foregroundStyle(.white)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(type.backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ToastView(type: .success("Login Successful"))
    ToastView(type: .error("Login Failed"))
    ToastView(type: .info("User Created"))
}
