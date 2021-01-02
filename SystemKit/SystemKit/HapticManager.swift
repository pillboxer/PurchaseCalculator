//
//  HapticManager.swift
//  SystemKit
//
//  Created by Henry Cooper on 26/12/2020.
//
#if os(iOS)
import UIKit
import CoreHaptics

public class HapticManager {
    
    private static var engine: CHHapticEngine?
    
    public static func performBasicHaptic(type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.impactOccurred()
    }
    
    public static func performFeedbackHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    public static func performComplexHaptic() {
        // FIXME: - 
        engine = try? CHHapticEngine()
        try? engine?.start()

        // create a dull, strong haptic
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)

        // create a curve that fades from 1 to 0 over one second
        let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
        let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)

        // use that curve to control the haptic strength
        let parameter = CHHapticParameterCurve(parameterID: .hapticSharpnessControl, controlPoints: [start, end], relativeTime: 0)

        // create a continuous haptic event starting immediately and lasting one second
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [sharpness, intensity], relativeTime: 0, duration: 0.5)

        if let pattern = try? CHHapticPattern(events: [event], parameterCurves: [parameter]) {
            let player = try? engine?.makePlayer(with: pattern)
            try? player?.start(atTime: 0)
        }
        
    }
}
#endif
