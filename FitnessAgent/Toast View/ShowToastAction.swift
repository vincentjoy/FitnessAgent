//
//  ShowToastAction.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

struct ShowToastAction {
    typealias Action = (ToastType) -> Void
    let action: Action
    
    func callAsFunction(_ type: ToastType) {
        action(type)
    }
}

extension EnvironmentValues {
    @Entry var showToast = ShowToastAction(action: { _ in })
}
