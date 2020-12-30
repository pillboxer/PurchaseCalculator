//
//  DetailedExplanationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 30/12/2020.
//

import SwiftUI
import SystemKit

struct DetailedExplanationDisplayView: View {
    
    var title: String
    var imageName: String
    var description: String
    
    var explanationOpacity: Double
    
    var body: some View {
        VStack {
            Spacer()
            Label(title)
                .underline()
            Label(description)
                .padding()
            Spacer()
        }
        .opacity(explanationOpacity)

        .padding()
        .onAppear {
            // FIXME: - 
            HapticManager.performFeedbackHaptic(.success)
        }
    }

    
}
