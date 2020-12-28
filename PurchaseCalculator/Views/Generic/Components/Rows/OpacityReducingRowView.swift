//
//  OpacityReducingRowView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/12/2020.
//

import SwiftUI

struct OpacityReducingRowView: View {
    
    @State private var opacity: Double = 1
    
    let title: String
    let imageName: String
    var divider: Bool = true
    var usesSystemImage: Bool = false
    var rowHandler: (() -> Void)?
    
    var shouldExecuteRowHandler: Bool {
        opacity != 1
    }
    
    var body: some View {
        RowViewWithButton(title: title, imageName: imageName, buttonHandler: self.reduceOpacity)
            .onTapGesture {
                reduceOpacity()
            }
            .onAppear { resetOpacity() }
            .opacity(opacity)
            .onAnimationCompleted(for: opacity) {
                shouldExecuteRowHandler ? rowHandler?() : nil
            }
            Divider()
                .frame(height: divider ? 1 : 0)
    }
    
    private func reduceOpacity() {
        withAnimation { opacity *= 0.5 }
    }
    
    private func resetOpacity() {
        withAnimation(.easeIn(duration: 0.8)) { opacity = 1 }
    }
    
}
