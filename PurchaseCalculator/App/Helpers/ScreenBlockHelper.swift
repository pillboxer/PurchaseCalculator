//
//  HomescreenBlockHelper.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 01/01/2021.
//

import SwiftUI
import PurchaseCalculatorDataKit
import Combine

class ScreenBlockHelper: ObservableObject {
    
    var selectedBlock: ScreenBlock?
    var isSelected = false
    var currentContext: Context
    
    var cancellable: AnyCancellable?
    
    enum Context {
        case home
        case evaluation
    }
    
    init(context: Context = .home) {
        self.currentContext = context
        setupBindings()
    }
    
    private func setupBindings() {
        cancellable = CoreDataManager.shared.objectWillChange.sink { (_) in
            if self.selectedBlock?.destination == nil {
                return
            }
            self.objectWillChange.send()
        }
    }
    
    
    func blocks(for container: BlockContainer) -> [ScreenBlock] {
        switch currentContext {
        case .home:
            return container.homescreenBlocks?.filter { return $0.destination == .history ? !Evaluation.allInstances.isEmpty : true } ?? []
        case .evaluation:
            return container.evaluationBlocks ?? []
        }
    }
    
    @ViewBuilder
    func view(isActive: Binding<Bool>) -> some View {
        switch selectedBlock?.destination {
        case .popular:
            EvaluationUnitSelectionView(units: DecodedObjectProvider.popularSpecificPurchaseUnits(limit: 10), isActive: isActive)
        case .userPreferences:
            UserPreferencesView()
        case .displayPreferences:
            DismissalButton()
        case .evaluation:
            EvaluationSelectionView(blockHelper: ScreenBlockHelper(context: .evaluation), isActive: isActive)
        case .error:
            // FIXME: - 
            Text("Oops! Something's gone wrong")
            DismissalButton()
        case .history:
            EvaluationHistoryView()
        case .brands:
            BrandSelectionView(isActive: isActive)
        case .items:
            ItemSelectionView(isActive: isActive)
        case .addYourOwn:
            ItemSelectionView(isActive: isActive, isAddingYourOwn: true)
        default:
            HomescreenView()
        }
    }
    
    func blockView(for container: BlockContainer, handler: @escaping (_ isModal: Bool) -> Void) -> some View {
        HStack {
            ForEach(blocks(for: container), id: \.uuid) { block in
                
                let period = self.currentContext == .home ? Double.random(in: 10...30) : nil
                let hiddenBool = (block.destination == .history && !UserDefaults.hasEvaluationHistory)
                let hiddenHandler = { UserDefaults.hasEvaluationHistory = true }
                
                CTAButton(text: block.handle,
                          imageWrapper: block.image,
                          animationPeriod: period,
                          hiddenTuple: (hiddenBool, hiddenHandler),
                          wideButton: block.isWide,
                          height: 120) {
                    
                    handler(block.destination.isModal)
                    self.selectedBlock = block
                    // So that the receiver has the updated view
                    self.objectWillChange.send()
                }
            }
            Spacer()
        }
        .padding(.top)
    }
    
}
