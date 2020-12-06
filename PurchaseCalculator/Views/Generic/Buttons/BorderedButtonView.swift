//
//  BorderedButtonView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct BorderedButtonView: View {
    
    let text: String
    @State var cornerRadius: CGFloat = 6
    @Environment(\.isEnabled) private var isEnabled: Bool
    var action: () -> Void
    @State var opacity: Double = 0.5
        
    var body: some View {
        Button(text, action: action)
            .modifier(StandardFontModifier())
            .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)
            .buttonStyle(PlainButtonStyle())
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.primary, lineWidth: 1.5))
            .opacity(opacity)
            .onChange(of: isEnabled) { enabled in
                changeColor(enabled: enabled)
            }
            .onAppear {
                changeColor(enabled: isEnabled)
            }
    }
    func changeColor(enabled: Bool) {
        withAnimation { opacity = enabled ? 1.0 : 0.5 }
    }

}
