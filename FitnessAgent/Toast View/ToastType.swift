//
//  ToastType.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI

enum ToastType {
    case success(String)
    case error(String)
    case info(String)
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return Color.green.opacity(0.9)
        case .error:
            return Color.red.opacity(0.9)
        case .info:
            return Color.blue.opacity(0.9)
        }
    }
    
    var icon: Image {
        switch self {
        case .success:
            return Image(systemName: "checkmark.circle")
        case .error:
            return Image(systemName: "xmark.octagon")
        case .info:
            return Image(systemName: "info.circle")
        }
    }
    
    var message: String {
        switch self {
        case .success(let msg), .error(let msg), .info(let msg):
            return msg
        }
    }
}


