//
//  StepperWithFillingRectangles.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI
import UIKit
import SystemKit

struct StepperWithFillingRectangles: View {
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var numberOfRectangles: Int
    var cornerRadiusForRectangles: CGFloat? = nil
    @Binding var valueToChange: Double
    @State private var scale: Double = 1
    @State var userWeighting: AttributeUserWeighting
    @State private var indexToScale: Int = 0
    var changeHandler: (Double) -> Void
    var body: some View {
        HStack {
            ForEach(0..<numberOfRectangles) { index in
                Rectangle()
                    .fill(fillColor(index))
                    .animation(.easeIn)
                    .frame(width: screenWidth / 10, height: 10)
                    .cornerRadius(cornerRadiusForRectangles ?? 0)
                    .overlay(RoundedRectangle(cornerRadius: cornerRadiusForRectangles ?? 0).stroke(Color.primary))
                    .onTapGesture {
                        UIApplication.endEditing()
                    }
                    .scaleEffect(index == indexToScale ? CGSize(width: scale, height: scale) : CGSize(width: 1, height: 1))
            }
            Spacer()
            Stepper("", value: $valueToChange, in: 0...1, step: 0.1)
                .onChange(of: valueToChange, perform: { _ in
                    scaleIfNecessary()
                    userWeighting = AttributeUserWeighting(weight: valueToChange)
                    changeHandler(valueToChange)
                })
            .frame(height: 20)
        }
        .onAnimationCompleted(for: scale) {
            withAnimation { scale = 1 }
        }
    }
    
    func scaleIfNecessary() {
        guard valueToChange == 0 || valueToChange == 1 else {
            return
        }
        if valueToChange == 1 {
            indexToScale = numberOfRectangles - 1
        }
        else if valueToChange == 0 {
            indexToScale = 0
        }
        withAnimation { scale = 1.3 }
        HapticManager.performComplexHaptic()
    }
    
    func fillColor(_ index: Int) -> Color {
        let valueAsPercentage = valueToChange * 100
        let indexAsPercentageOfAllRectangles = Double(index) / Double(numberOfRectangles) * 100
        return valueAsPercentage >= indexAsPercentageOfAllRectangles ? userWeighting.color : Color.systemBackground
    }
}
