//
//  SaveEvaluationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/12/2020.
//

import SwiftUI

struct SaveEvaluationView: View {
    
    var saveHandler: () -> Void
    
    var body: some View {
        HStack {
            BorderedButtonView(text: "save_cta") {
                saveHandler()
            }
            DismissalButton()
        }
        .frame(maxHeight: 40)
        .padding()
    }
}
