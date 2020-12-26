//
//  PurchaseAttributeSummaryView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 26/12/2020.
//

import SwiftUI

struct PurchaseAttributeSummaryView: View {
    
    @State var alertShowing = false
    var selectedEvaluation: EvaluationManager.AttributeEvaluation
    var itemName: String
    var body: some View {
        HStack {
            ImageAndTextView(imageName: selectedEvaluation.attributeImageName, text: selectedEvaluation.attributeName)
                .frame(maxWidth: UIScreen.main.bounds.width)
            Divider(horizontal: false)
            BulletListView(evaluation: selectedEvaluation)
                .frame(maxWidth: UIScreen.main.bounds.width)
                .onTapGesture {
                    alertShowing = true
                }
                .alert(isPresented: $alertShowing) {
                    Alert(title: Text("Important message"), message: Text("\(selectedEvaluation.attributeResult.rawValue.capitalized) represents the rating of the selected attribute.\n\n \(selectedEvaluation.userWeighting.description.capitalized) represents the meaningfulness of this attribute to you"), dismissButton: .default(Text("Got it!")))
                     }
        }
        .frame(maxHeight: 100)
    }
    
}

struct ImageAndTextView: View {
    
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.bottom, 4)
            PCTextView(text)
        }
    }
    
}

struct BulletListView: View {
    
    var evaluation: EvaluationManager.AttributeEvaluation
    
    var body: some View {
        VStack(alignment: .leading) {
            CircleAndTextView(text: evaluation.attributeResult.rawValue.capitalized, color: evaluation.attributeResult.evaluationColor)
            CircleAndTextView(text: evaluation.userWeighting.description.capitalized, color: .gray)
        }
    }
    
}

struct CircleAndTextView: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            PCTextView(text)
        }
    }
    
}
