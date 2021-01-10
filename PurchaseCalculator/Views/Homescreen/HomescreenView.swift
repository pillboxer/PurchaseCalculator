//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI
import SystemKit

protocol Presenter: View {
    associatedtype Presented: View
    var presentee: Presented { get }
    var presenting: Bool { get set }
}

struct HomescreenView: View {
    
    @ObservedObject var coreDataManager = CoreDataManager.shared
    @StateObject private var blockHelper = ScreenBlockHelper()
    @State private var isPresenting = false
    @State private var isPushing = false
    @State private var opacity: Double = 0
    
    var body: some View {
        EmptorColorSchemeAdaptingView {
            bodyToShow
        }
    }
    
    @ViewBuilder
    private var bodyToShow: some View {
        if !User.doesExist {
            NoUserHomescreen()
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
        .opacity(opacity)
        .onAppear {
            withAnimation { opacity = 1 }
        }        
    }
}

