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
        let topSelectedKey = "detailed_summary_description_left_bar"
        let bottomSelectedKey = "detailed_summary_description_right_bar"
        let key = topSelected ? topSelectedKey : bottomSelectedKey
        let formatter = AttributeEvaluationStringFormatter(evaluation: selectedEvaluation, itemName: itemName, unformattedString: key)
        return formatter.formattedString
    }
    
    var color: Color {
        topSelected ? ColorManager.evaulationResultColorFor(selectedEvaluation.attributeResult) : .gray
    }
    
    var body: some View {
        HStack {
            CircleAndTextView(text: text, color: color)
                .frame(maxWidth: 300)
            Spacer()
            BorderedButtonView(text: "ok_cta", width: 50, height: 30, action: tapHandler)
            Spacer()
        }
        .padding(.horizontal)
    }
    
}
