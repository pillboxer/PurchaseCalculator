//
//  StepperWithFillingRectangles.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI
import UIKit

struct StepperWithFillingRectangles: View {
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var numberOfRectangles: Int
    var cornerRadiusForRectangles: CGFloat? = nil
    @State var valueToChange: Double
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
            }
            Spacer()
            Stepper("",
                    onIncrement: {
                        self.valueToChange = min(1, self.valueToChange + 0.05)
                        changeHandler(valueToChange)
                    },
                    onDecrement: {
                        self.valueToChange = max(0, self.valueToChange - 0.05)
                        changeHandler(valueToChange)
                    }
            )
            .frame(height: 20)
        }
    }
    
    func fillColor(_ index: Int) -> Color {
        let valueAsPercentage = valueToChange * 100
        let indexAsPercentageOfAllRectangles = Double(index) / Double(numberOfRectangles) * 100
        return valueAsPercentage >= indexAsPercentageOfAllRectangles ? colorForWeight(valueToChange) : Color(UIColor.systemBackground)
    }
    
    private func colorForWeight(_ weight: Double) -> Color {
        let red = min(0.5, weight)
        let blue = max(0.5, 1-weight)
        let green = max(0.5, weight)
        let color = Color(red: red, green: green, blue: blue, opacity: 1)
        return color
    }
}
