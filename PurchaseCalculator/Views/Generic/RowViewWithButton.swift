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
    let selected: Bool
    let animation: Bool
    var divider: Bool = true
    
    var rowHandler: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 20, maxHeight: 20)
                .padding(.trailing)
            Text(title)
                .modifier(StandardFontModifier())
            Spacer()
            Button(action: {
                rowHandler?()
            }) {
                Image(systemName: "arrow.right.circle")
            }
            .accentColor(.primary)
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .onTapGesture {
            rowHandler?()
        }
        .opacity(selected ? 0.5 : 1)
        .animation(animation ? .easeOut : .none)
        Rectangle()
            .fill(Color.primary)
            .frame(height: divider ? 1 : 0)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
}
