//
//  ReportRowView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 10/01/2021.
//

import SwiftUI

struct ReportRowView: View {
    
    var title: String
    var value: String
    var valueColor: Color?
    var imageName: String
    var inspectionHandler: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            Label(title)
                .padding(.leading)
            if let inspectionHandler = inspectionHandler {
                Image("question")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        inspectionHandler()
                    }
            }
            Spacer()
            Label(value)
                .foregroundColor(valueColor)
        }
        .padding(.horizontal)
    }
    
}
