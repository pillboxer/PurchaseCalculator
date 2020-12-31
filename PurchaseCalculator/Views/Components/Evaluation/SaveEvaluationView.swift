//
//  SaveEvaluationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 28/12/2020.
//

import SwiftUI

struct SaveEvaluationView: View {
    
    var body: some View {
        HStack {
            BorderedButtonView(text: "Save Result") {
                print("Save")
            }
            BorderedButtonView(text: "Discard Result") {
                print("Discard")
            }
        }
        .frame(maxHeight: 40)
        .padding()
    }
}
