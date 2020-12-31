//
//  ExplanationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//

import SwiftUI

struct AttributesDetailsView: View {
    
    @StateObject private var viewModel = ExplanationViewModel()
    @State private var selectedExplanationIndex: Int? = nil
    @State private var explanationOpacity: Double = 0
    @State private var viewOpacity: Double = 1
    var handler: () -> Void
    
    var body: some View {
        VStack {
            
            // Top Icons
            AttributeIconsDisplayView(iconNames: viewModel.iconNames,
                                      topIndexDisplayed: viewModel.topIndexDisplayed,
                                      selectedIndex: $selectedExplanationIndex)
                .opacity(viewModel.showsIconGroupDisplay ? 1 : 0)
                .animation(selectedExplanationIndex == nil ? .easeIn : .none)
                .disabled(explanationOpacity != 1)
                .padding(.top)
                .hidden(!viewModel.showsIconGroupDisplay)
            Label(viewModel.iconsSubheaderText)
                .hidden(!viewModel.showsDetailedDescriptions)
                .animation(.easeIn)
            
            // Middle of screen info
            if viewModel.showsDetailedDescriptions {
                DetailedExplanationDisplayView(title: viewModel.detailedDescriptionTitle,
                                               imageName: viewModel.detailedDescriptionImageName,
                                               description: viewModel.detailedDescription,
                                               explanationOpacity: explanationOpacity)
            }
            if viewModel.showsPulsingView {
                PulsingIntroView(viewModel: viewModel)
            }
            
            // CTA
            AttributesDetailsCTAView {
                withAnimation(.linear(duration: 2) ) { viewOpacity = 0 }
            }
            .hidden(!viewModel.showsCTA)
            .animation(.easeIn)
        }
        .opacity(viewOpacity)
        .onChange(of: viewModel.currentContext) { context in
            if context == .complete {
                selectedExplanationIndex = 0
            }
            else {
                selectedExplanationIndex = nil
            }
        }
        .onChange(of: selectedExplanationIndex, perform: { [selectedExplanationIndex] value in
            if selectedExplanationIndex == nil {
                increaseOpacity()
            }
            else {
                reduceOpacity()
            }
        })
        .onAnimationCompleted(for: explanationOpacity) {
            if explanationOpacity == 0,
               let value = selectedExplanationIndex {
                viewModel.updateSelectedAttributeIndex(value)
            }
            increaseOpacity()
        }
        .onAnimationCompleted(for: viewOpacity) {
            if viewOpacity == 0 {
                handler()
            }
        }
    }
    
    private func reduceOpacity() {
        withAnimation(.linear(duration: 0.5)) { explanationOpacity = 0 }
    }
    
    private func increaseOpacity() {
        withAnimation(.linear(duration: 0.5)) { explanationOpacity = 1 }
    }

}

struct AttributesDetailsCTAView: View {
    
    var handler: () -> Void
    
    var body: some View {
        BorderedButtonView(text: "Close", action: handler)
            .frame(width: 100, height: 50)
        .padding()
    }
    
}
