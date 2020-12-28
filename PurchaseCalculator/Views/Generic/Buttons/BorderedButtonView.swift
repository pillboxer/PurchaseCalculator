//
//  BorderedButtonView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct CustomColoredTextButtonStyle: ButtonStyle {
    
    var unselectedColor: Color
    var selectedColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? selectedColor : unselectedColor)
    }
    
}

struct BorderedButtonView: View {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    @State private var opacity: Double = 0.5
    @State private var currentColor: Color = .primary
    private let cornerRadius: CGFloat = 6
    
    let text: String
    var action: () -> Void
    
    var body: some View {
        Button(text, action: action)
            .modifier(StandardFontModifier())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .buttonStyle(PlainButtonStyle())
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(currentColor, lineWidth: 1.5))
            .foregroundColor(currentColor)
            .opacity(opacity)
            .onChange(of: isEnabled) { enabled in
                changeOpacity(for: enabled)
            }
            .onAppear {
                changeOpacity(for: isEnabled)
            }
            .gesture(DragGesture(minimumDistance: 0.0)
                        .onChanged { _ in
                            changeOpacity(for: false)
                        }
                        .onEnded { dragging in
                            let movementInEitherAxis = max(abs(dragging.translation.width), abs(dragging.translation.height))
                            let pressed = movementInEitherAxis < 40
                            if pressed {
                                action()
                            }
                            else {
                                changeOpacity(for: pressed)
                            }
                        })
    }
    
    private func changeOpacity(for enabled: Bool) {
        withAnimation { opacity = enabled ? 1.0 : 0.5 }
    }
    
}
