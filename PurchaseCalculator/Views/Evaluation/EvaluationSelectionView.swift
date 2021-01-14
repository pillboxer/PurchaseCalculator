//
//  EvaluationSelectionView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

import SwiftUI

struct EvaluationSelectionView: View {
    
    @State var selectedBlock: ScreenBlock?
    // FIXME: - Can this just a var? Does it still deinit if StateObject?
    @ObservedObject var blockHelper: ScreenBlockHelper
    @State var isPushing: Bool = false
    @Binding var isActive: Bool
    
    var body: some View {
        BasicNavigationView {
            AttributeIconsGroupView()
            NavigationLink("", destination: blockHelper.view(isActive: $isActive), isActive: $isPushing)
            ForEach(DecodedObjectProvider.evaluationScreenBlockContainers ?? [], id: \.uuid) { container in
                blockHelper.blockView(for: container) { isModal in
                    isPushing = !isModal
                }
            }
        }
    }
}
