//
//  AttributeIconsSelectableDisplayView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 30/12/2020.
//

import SwiftUI

struct AttributeIconsDisplayView: View {
    
    var iconNames: [String]
    var topIndexDisplayed: Int
    @Binding var selectedIndex: Int?
    
    func indexOf(_ name: String) -> Int {
        iconNames.firstIndex(of: name) ?? 0
    }
    
    func showIcon(_ name: String) -> Bool {
        indexOf(name) <= topIndexDisplayed
    }
    
    var body: some View {
        HStack {
            ForEach(iconNames, id: \.self) { iconName in
                VStack {
                    Image(iconName)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .opacity(showIcon(iconName) ? 1 : 0)
                        .animation(.easeIn)
                        .onTapGesture {
                            selectedIndex = indexOf(iconName)
                        }
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 25, height: 2)
                        .padding(2)
                        .hidden(indexOf(iconName) != selectedIndex)
                }
                .padding(2)
            }
        }
    }
    
}
