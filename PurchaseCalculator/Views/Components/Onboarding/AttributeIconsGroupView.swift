//
//  AttributeIconsGroupView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI

struct AttributeIconsGroupView: View {
    
    @StateObject var viewModel = AttributeIconsGroupViewModel()
    @State var offset: Double = 0
    @State private var indexToAnimate = 0
    
    private func getNewIndex() -> Int {
        let new = Int.random(in: 0..<viewModel.iconNames.count)
        return new == indexToAnimate ? getNewIndex() : new
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(viewModel.iconNames, id: \.self) { icon in
                AnimatingIconView(iconName: icon, shouldAnimate: icon == viewModel.iconNames[indexToAnimate]) {
                    indexToAnimate = getNewIndex()
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
                    animateOffset(up: true)
                }
            }
            .onAppear {
                if shouldAnimate {
                    animateOffset(up: true)
                }
            }
            .onAnimationCompleted(for: offset) {
                if offset != 0 { animateOffset(up: false) }
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.1...3.0), execute: handler)
                }
            }
    }
    
    private func animateOffset(up: Bool) {
        withAnimation(.linear(duration: 0.2)) { offset = up ? -2 : 0 }
    }
    
}

class AttributeIconsGroupViewModel: ObservableObject {
    
    @Published var iconNames: [String] = []
    
    
    init() {
        self.iconNames = DecodedObjectProvider.attributes()?.compactMap { $0.symbol } ?? []
    }
    
}
