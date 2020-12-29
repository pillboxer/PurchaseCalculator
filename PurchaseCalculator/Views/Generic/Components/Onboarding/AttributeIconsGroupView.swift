//
//  AttributeIconsGroupView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI

struct AttributeIconsGroupView: View {
    
    var viewModel = AttributeIconsGroupViewModel()
    @State var offset: Double = 0
    @State private var indexToAnimate = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack(spacing: 16) {
            ForEach(viewModel.iconNames, id: \.self) { icon in
                AnimatingIconView(iconName: icon, shouldAnimate: icon == viewModel.iconNames[indexToAnimate % viewModel.iconNames.count]) {
                    indexToAnimate += 1
                }
            }
        }
        
    }
    
}

struct AnimatingIconView: View {
    
    var iconName: String
    var shouldAnimate: Bool
    var handler: () -> Void
    @State private var offset: Double = 0
    
    var body: some View {
        Image(iconName)
            .resizable()
            .frame(width: 25, height: 25)
            .offset(CGSize(width: 0, height: offset))
            .onChange(of: shouldAnimate) { newValue in
                if newValue == true {
                    animateOffset()
                }
            }
            .onAppear {
                if shouldAnimate {
                    animateOffset()
                }
            }
            .onAnimationCompleted(for: offset) {
                if offset != 0 { withAnimation(.linear(duration: 0.3)) { offset = 0 } }
                else {
                    handler()
                }
            }
    }
    
    func animateOffset() {
        withAnimation(.linear(duration: 0.3)) { offset -= 3 }
    }
    
}

struct AttributeIconsGroupViewModel {
    
    var iconNames: [String] {
        DecodedObjectProvider.attributes?.compactMap { $0.symbol } ?? []
    }
    
}
