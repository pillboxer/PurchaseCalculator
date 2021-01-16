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
    
    let text: String?
    let imageName: String?
    let width: CGFloat?
    let height: CGFloat?
    var action: () -> Void
    
    init(text: String?, imageName: String? = nil, width: CGFloat? = nil, height: CGFloat? = nil, action: @escaping () -> Void) {
        self.text = text
        self.imageName = imageName
        self.width = width
        self.height = height
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack {
                if let imageName = imageName {
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .frame(width: 25, height: 25)
                        Spacer()
                }
                if let text = text {
                    Label(String.forKey(text))
                }
                if let _ = imageName {
                    Spacer()
                }
            }

        }
            .frame(width: width ?? 100, height: height ?? 50)
            .buttonStyle(PlainButtonStyle())
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(currentColor, lineWidth: 1.5))
            .foregroundColor(currentColor)
            .opacity(opacity)
            .onChange(of: isEnabled) { enabled in
                changeOpacity(for: enabled)
            }
            .onAppear {
                opacity = 1
            }
    }
    
    private func changeOpacity(for enabled: Bool) {
        withAnimation { opacity = enabled ? 1.0 : 0.5 }
    }
    
}
