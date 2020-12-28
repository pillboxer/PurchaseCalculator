//
//  ExpandableRowView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 23/12/2020.
//

import SwiftUI

struct ExpandableRowView<ExpandedContent: View>: View {
    
    var isExpanded: Bool
    var title: String
    var expandedContent: ExpandedContent
    var divider: Bool = true
    var buttonRotation: Double {
        return isExpanded ? 90 : 0
    }
    
    @State private var opacity: Double = 1
    
    var expansionHandler: ((Bool) -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            RowViewWithButton(title: title, imageName: nil, buttonRotation: buttonRotation, buttonHandler: toggle)
                .onTapGesture(perform: toggle)
            expandedContent
                .hidden(!isExpanded)
                .padding([.leading, .bottom, .trailing])
                .frame(maxHeight: isExpanded ? .infinity : 0)
                .modifier(StandardFontModifier())
                .opacity(opacity)
            Divider()
                .frame(height: divider ? 1 : 0)
        }
    }
    
    private func toggle() {
        expansionHandler?(!isExpanded)
    }
    
}
