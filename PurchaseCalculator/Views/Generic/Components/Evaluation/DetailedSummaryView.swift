//
//  DetailedSummaryView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 27/12/2020.
//

import SwiftUI

struct DetailedSummaryView: View {
    
    var selectedEvaluation: AttributeEvaluation
    var itemName: String
    var topSelected: Bool
    var tapHandler: () -> Void
    
    var text: String {
        topSelected ? "The left bar of the graph. The \(itemName.lowercased()) category has \(selectedEvaluation.attributeResult.descriptionWithArticle) \(selectedEvaluation.attributeName) score" : "The right bar of the graph. Looks at your preferences and determines the effect of the \(selectedEvaluation.attributeResult.description) score on your result below"
    }
    
    var color: Color {
        topSelected ? ColorManager.evaulationResultColorFor(selectedEvaluation.attributeResult) : .gray
    }
    
    var body: some View {
        HStack {
            CircleAndTextView(text: text, color: color)
                .frame(maxWidth: 300)
            Spacer()
            BorderedButtonView(text: "OK", action: tapHandler)
                .frame(width: 50, height: 30)
            Spacer()
        }
        .padding(.horizontal)
    }
    
}
