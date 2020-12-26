//
//  HapticManager.swift
//  SystemKit
//
//  Created by Henry Cooper on 26/12/2020.
//

import UIKit

public class HapticManager {
    
    public static func performBasicHaptic(type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.impactOccurred()
    }
    
    public static func performFeedbackHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
}
