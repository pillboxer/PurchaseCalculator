//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI
import SystemKit

struct HomescreenView: View {
    
    @StateObject private var blockHelper = ScreenBlockHelper()
    @State private var isPresenting = false
    @State private var isPushing = false
    @State private var opacity: Double = 0
    @ObservedObject var noUserViewModel = NoUserHomescreenViewModel()

    var body: some View {
        EmptorColorSchemeAdaptingView {
            bodyToShow
        }
    }
    
    @ViewBuilder
    private var bodyToShow: some View {
        if !User.doesExist {
            NoUserHomescreen(viewModel: noUserViewModel)
        }
        else {
            homescreenBlocksView
        }
    }
    
    private var homescreenBlocksView: some View {
        VStack {
            AttributeIconsGroupView()
            NavigationLink("", destination: blockHelper.view, isActive: $isPushing)
            ForEach(DecodedObjectProvider.homescreenBlockContainers ?? [], id: \.uuid) { container in
                blockHelper.blockView(for: container) { isModal in
                    isPresenting = isModal
                    isPushing = !isModal
                }
                .fullScreenCover(isPresented: $isPresenting) {
                    blockHelper.view
                }
            }
            Spacer()
        }
        .padding()
    }
}

