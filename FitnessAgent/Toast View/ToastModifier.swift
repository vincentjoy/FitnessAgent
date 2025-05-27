//
//  ToastModifier.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    @State private var type: ToastType?
    @State private var dismissTask: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .environment(\.showToast, ShowToastAction(action: { type in
                withAnimation(.easeInOut) {
                    self.type = type
                }
                
                // Cancel previous task
                dismissTask?.cancel()
                
                // Schedule a new dismissal
                let task = DispatchWorkItem {
                    withAnimation(.easeInOut) {
                        self.type = nil
                    }
                }
                
                self.dismissTask = task
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: task)
            }))
            .overlay(alignment: .top) {
                if let type {
                    ToastView(type: type)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.top, 50)
                }
            }
    }
}

extension View {
    func withToast() -> some View {
        modifier(ToastModifier())
    }
}
