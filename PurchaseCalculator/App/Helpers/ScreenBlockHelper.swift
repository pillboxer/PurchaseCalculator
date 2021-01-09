//
//  HomescreenBlockHelper.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 01/01/2021.
//

import SwiftUI
import PurchaseCalculatorDataKit

class ScreenBlockHelper: ObservableObject {
    
    var selectedBlock: ScreenBlock?
    var isSelected = false
    var currentContext: Context
    
    enum Context {
        case home
        case evaluation
    }
    
    init(context: Context = .home) {
        self.currentContext = context
    }
    
    func blocks(for container: BlockContainer) -> [ScreenBlock] {
        switch currentContext {
        case .home:
            return container.homescreenBlocks ?? []
        case .evaluation:
            return container.evaluationBlocks ?? []
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch selectedBlock?.destination {
        case .popular:
            EvaluationUnitSelectionView(units: DecodedObjectProvider.popularSpecificPurchaseUnits(limit: 10))
        case .userPreferences:
            UserPreferencesView()
        case .displayPreferences:
            DismissalButton()
        case .evaluation:
            EvaluationSelectionView(blockHelper: ScreenBlockHelper(context: .evaluation))
        default:
            HomescreenView()
        }
    }
    
    func blockView(for container: BlockContainer, handler: @escaping (_ isModal: Bool) -> Void) -> some View {
        HStack {
                ForEach(blocks(for: container), id: \.uuid) { block in
                    CTAButton(text: block.handle, imageName: block.imageName, width: block.isWide ? .infinity : 100, height: 100) {
                        handler(block.destination.isModal)
                        self.selectedBlock = block
                        self.objectWillChange.send()
                    }
                }
            Spacer()
            }
        .padding(.top)
        }
    
}
