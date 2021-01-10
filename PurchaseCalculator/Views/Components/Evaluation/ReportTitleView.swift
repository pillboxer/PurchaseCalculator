//
//  ReportTitleView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 10/01/2021.
//

import SwiftUI

struct ReportTitleView: View {
    
    var text: String
    
    var body: some View {
        HStack {
            Divider().padding(.leading)
            Label(text).padding(.horizontal)
                .layoutPriority(.greatestFiniteMagnitude)
            Divider().padding(.trailing)
        }
    }
}
