//
//  BasicSummaryView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 27/12/2020.
//

import SwiftUI

struct BasicSummaryView: View {
    
    var selectedEvaluation: AttributeEvaluation
    var tapHandler: (_ isTop: Bool) -> Void
    
    var body: some View {
        HStack {
            ImageAndTextView(imageName: selectedEvaluation.attributeImageName, text: selectedEvaluation.attributeName)
                .frame(maxWidth: UIScreen.main.bounds.width)
            Divider(horizontal: false)
            BasicSummaryBulletView(evaluation: selectedEvaluation) { isTop in
                tapHandler(isTop)
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
        }
    }
}

