//
//  RowViewWithButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

struct RowViewWithButton: View {
        
    let title: String
    let imageName: String
    let id: String
    var divider: Bool = true
    var usesSystemImage: Bool 
    
    var rowHandler: (() -> Void)?
    @State var opacity: Double = 1
    
    var shouldExecuteRowHandler: Bool {
        opacity != 1
    }
    
    var image: Image {
        usesSystemImage ? Image(systemName: imageName) : Image(imageName)
    }
    
    var body: some View {
        HStack {
            image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 20, maxHeight: 20)
                .padding(.trailing)
            Text(title)
                .modifier(StandardFontModifier())
            Spacer()
            Button(action: {
                reduceOpacity()
            }) {
                Image(systemName: "arrow.right.circle")
            }
            .accentColor(.primary)
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .onTapGesture {
            reduceOpacity()
        }
        .onAppear { resetOpacity() }
        .opacity(opacity)
        .onAnimationCompleted(for: opacity) {
            shouldExecuteRowHandler ? rowHandler?() : nil
        }
        Rectangle()
            .fill(Color.primary)
            .frame(height: divider ? 1 : 0)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
    func reduceOpacity() {
        withAnimation { opacity *= 0.5 }
    }
    
    func resetOpacity() {
        withAnimation(.easeIn(duration: 0.8)) { opacity = 1 }
    }
    
}
