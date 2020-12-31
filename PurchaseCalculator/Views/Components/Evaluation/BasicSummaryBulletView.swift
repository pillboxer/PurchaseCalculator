//
//  BasicSummaryBulletView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 27/12/2020.
//

import SwiftUI

struct BasicSummaryBulletView: View {
    
    var evaluation: AttributeEvaluation
    var tapHandler: (_ isTop: Bool) -> Void
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                CircleAndTextView(text: evaluation.attributeResult.description.capitalized, color: ColorManager.evaulationResultColorFor(evaluation.attributeResult), inspectionHandler: topTapped)
                CircleAndTextView(text: evaluation.userWeighting.description.capitalized, color: .gray, inspectionHandler: bottomTapped)
            }
        }
    }
    
    private func topTapped() {
        tapHandler(true)
    }
    
    private func bottomTapped() {
        tapHandler(false)
    }
}

