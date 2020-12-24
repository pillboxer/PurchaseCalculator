//
//  EvaluationCalculationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 24/12/2020.
//

import SwiftUI

struct EvaluationCalculationView: View {
    
    var evaluationManager: EvaluationManager
    @State var hideImage: Bool = false
    @State private var animationComplete: Bool = false
    
    var evaluation: EvaluationManager.Evaluation {
        evaluationManager.evaluation!
    }
    
    init(evaluationManager: EvaluationManager) {
        self.evaluationManager = evaluationManager
    }
    
    var body: some View {
        BasicNavigationView {
            VStack(alignment: .center) {
                Spacer()
                HStack {
                    Spacer()
                    EvaluationGaugeView(score: evaluation.score, resultColor: evaluation.result.evaluationColor, animationComplete: $animationComplete)
                    Spacer()
                }
                Text(evaluation.result.description)
                    .opacity(animationComplete ? 1 : 0)
                    .modifier(StandardFontModifier(size: 20))
            }
        }
        .hidePopImage(!animationComplete)
    }
}

struct EvaluationGaugeView: View {
    
    var score: Double = 0
    var resultColor: Color
    @Binding var animationComplete: Bool
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var completion: CGFloat = 0
    @State private var opacity: Double = 0
    
    private var colorForCompletion: Color {
        let range = Double.random(in: 0.70...0.79)
        return Color(red: 0, green: 0.5, blue: range, opacity: 1)
    }
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(resultColor)
                .frame(width: 160, height: 160)
                .opacity(opacity)
            Circle()
                .trim(from: 0, to: completion)
                .stroke(colorForCompletion, lineWidth: 60)
                .frame(width: 100, height: 100)
            Circle()
                .strokeBorder(resultColor, lineWidth: 3)
                .frame(width: 160, height: 160)
                .opacity(opacity)
        }
        .rotationEffect(.degrees(-90))
        .onReceive(timer) { _ in
            withAnimation {
                self.completion = min(completion + 0.1, 1)
            }
        }
        .onAnimationCompleted(for: completion) {
            timer.upstream.connect().cancel()
            withAnimation {
                opacity = 1
            }
        }
        .onAnimationCompleted(for: opacity) {
            withAnimation { animationComplete = true }
        }
    }
}
