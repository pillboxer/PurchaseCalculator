//
//  InspectionRowView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 10/01/2021.
//

import SwiftUI

struct InspectionRowView: View {
    
    var closeHandler: () -> Void
    var text: String
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 25, height: 25)
            Label(text, size: 10)
                .padding(.horizontal)
                .frame(height: 40)
            Spacer()
            BorderedButtonView(text: "ok_cta", width: 40, height: 25, action: closeHandler)
        }
        .padding(.horizontal)
        .onTapGesture {
            closeHandler()
        }
    }
}
