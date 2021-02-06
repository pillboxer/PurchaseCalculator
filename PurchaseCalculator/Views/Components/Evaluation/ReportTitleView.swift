//
//  ReportTitleView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 10/01/2021.
//

import SwiftUI

struct ReportTitleView: View {
    
    var text: String
    var imageName: String? = nil
    
    var body: some View {
        HStack {
            Divider().padding(.leading)
            if let imageName = imageName {
                Image(named: imageName)
                    .resizable()
                    .frame(width: 10, height: 10)
            }
            Label(text).padding(.horizontal)
                .layoutPriority(.greatestFiniteMagnitude)
            if let imageName = imageName {
                Image(named: imageName)
                    .resizable()
                    .frame(width: 10, height: 10)
            }
            Divider().padding(.trailing)
        }
    }
}
