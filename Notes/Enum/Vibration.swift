//
//  Vibration.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import UIKit
import AudioToolbox

enum Vibration {
    case error
    
    public func vibrate() {
        switch self {
        case .error: UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}
