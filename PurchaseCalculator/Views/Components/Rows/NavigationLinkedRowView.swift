//
//  NavigationLinkView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI
import SystemKit

struct NavigationLinkedRowView<T: RowType, Destination: View>: View {
    
    let item: T
    let destinationController: Destination
    @Binding var selectedID: String?
    var divider: Bool = true
    var rowHandler: (() -> Void)?
    
    var imageName: String {
        item.imageName.existsAsImage ? item.imageName : "calculate"
    }
    
    var body: some View {
        NavigationLink(destination: destinationController, tag: item.id, selection: $selectedID) {}
        OpacityReducingRowView(title: item.rowTitle,
                          imageName: imageName,
                          divider: divider,
                          usesSystemImage: item.isSystemImage,
                          rowHandler: rowHandler)
    }
    
}
