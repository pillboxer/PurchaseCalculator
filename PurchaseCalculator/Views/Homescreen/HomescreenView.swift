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
    @ObservedObject var noUserViewModel = NoUserHomescreenViewModel()
    @State private var isShowingAlert = false
    var body: some View {
        EmptorColorSchemeAdaptingView {
            bodyToShow
                // FIXME: - 
                .alert(isPresented: $isShowingAlert, content: {
                    Alert(title: Text("No Images Found"),
                          message: Text("Please Make sure you have connection to the internet"),
                          dismissButton: .default(Text("OK")))
                })
                .onAppear {
                    isShowingAlert = !FileManager.default.folderInLibraryExists(name: "Emptor/Assets")
                }
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
            NavigationLink("", destination: blockHelper.view(isActive: $isPushing), isActive: $isPushing)
            ForEach(DecodedObjectProvider.homescreenBlockContainers ?? [], id: \.uuid) { container in
                blockHelper.blockView(for: container) { isModal in
                    isPresenting = isModal
                    isPushing = !isModal
                }
                .fullScreenCover(isPresented: $isPresenting) {
                    blockHelper.view(isActive: $isPushing)
                }
            }
            Spacer()
        }
        .padding()
    }
}

