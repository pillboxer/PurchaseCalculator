//
//  NavigationLinkView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

struct NavigationLinkedRowView<T: RowType, Destination: View>: View {
    
    let item: T
    let destinationController: Destination
    @Binding var selectedID: String?
    var divider: Bool = true
    var rowHandler: (() -> Void)?
    
    var body: some View {
        NavigationLink(destination: destinationController, tag: item.id, selection: $selectedID) {}
        RowViewWithButton(title: item.title,
                          imageName: item.imageName,
                          id: item.id,
                          divider: divider,
            rowHandler: rowHandler)
    }
    
}
