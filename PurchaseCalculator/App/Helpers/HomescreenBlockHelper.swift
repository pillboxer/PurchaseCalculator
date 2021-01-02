//
//  HomescreenBlockHelper.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 01/01/2021.
//

import SwiftUI

class HomescreenBlockHelper {
    
    var selectedBlock: HomescreenBlock?
    
    @ViewBuilder
    func view() -> some View {
        switch selectedBlock?.destination {
        case .popular:
            Text("popular")
        case .preferences:
            UserPreferencesView()
        default:
            Text("Ooops")
        }
    }
    
    init() {
        print("Block init")
    }
    
    func blockView(for block: HomescreenBlock, handler: @escaping () -> Void) -> some View {
        BorderedButtonView(text: block.handle, imageName: block.imageName, width: block.isWide ? .infinity : 100, height: 100) {
            handler()
        }
    }
    
}
