//
//  EvaluationSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

import SwiftUI

struct EvaluationSelectionView: View {
    
    @State var selectedBlock: ScreenBlock?
    @StateObject var blockHelper: ScreenBlockHelper
    @State var isPushing: Bool = false
    
    var body: some View {
        BasicNavigationView {
            AttributeIconsGroupView()
            NavigationLink("", destination: blockHelper.view, isActive: $isPushing)
            ForEach(DecodedObjectProvider.evaluationScreenBlockContainers ?? [], id: \.uuid) { container in
                blockHelper.blockView(for: container) { isModal in
                    isPushing = !isModal
                }
            }
        }
    }
    
    
    func blockView(for container: BlockContainer, handler: @escaping () -> Void) -> some View {
        HStack {
            ForEach(container.evaluationBlocks ?? [], id: \.uuid) { block in
                BorderedButtonView(text: block.handle, imageName: block.imageName, width: block.isWide ? .infinity : 100, height: 100) {
                    handler()
                    self.selectedBlock = block
                }
            }
            Spacer()
        }
        .padding(.top)
    }
    
}
