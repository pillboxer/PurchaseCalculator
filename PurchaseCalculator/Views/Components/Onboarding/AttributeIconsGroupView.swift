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
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(viewModel.iconNames, id: \.self) { icon in
                AnimatingIconView(iconName: icon)
            }
        }
    }
    
}

struct AnimatingIconView: View {
    
    var iconName: String
    @State private var shouldAnimate: Bool = false
    @State private var offset: Double = 0
    private let timer = Timer.publish(every: Double.random(in: 3...5), on: RunLoop.current, in: .common).autoconnect()
    
    var body: some View {
        Image(iconName)
            .resizable()
            .frame(width: 25, height: 25)
            .offset(CGSize(width: 0, height: offset))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1...3)) {
                    shouldAnimate = Bool.random()
                }
            }
            .onChange(of: shouldAnimate, perform: { value in
                if value {
                    animateOffset(up: true)
                }
            })
            .onAnimationCompleted(for: offset) {
                if offset != 0 { animateOffset(up: false) }
            }
            .onReceive(timer, perform: { _ in
                shouldAnimate = Bool.random()
            })
    }
    
    private func animateOffset(up: Bool) {
        withAnimation(.linear(duration: 0.2)) {
            offset = up ? -2 : 0
    
        }
    }
    
}

class AttributeIconsGroupViewModel: ObservableObject {
    
    @Published var iconNames: [String] = []
    
    
    init() {
        self.iconNames = DecodedObjectProvider.attributes()?.compactMap { $0.symbol } ?? []
    }
    
}
