//
//  NewUserHomescreen.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/12/2020.
//

import SwiftUI
import SystemKit

class NoUserHomescreenViewModel: ObservableObject {
    
    func markUserExists() {
        objectWillChange.send()
    }
    
}

struct NoUserHomescreen: View {
        
    var viewModel: NoUserHomescreenViewModel
    @State var presenting: Bool = false
    @State private var animationHandler: (() -> Void)?
    var presentee: some View {
        UserPreferencesView()
    }
    
    var body: some View {
            VStack {
                Spacer()
                CTAButton(text: "add_profile_cta", imageWrapper: ImageWrapper(name: "profile_block_cta_image_template"), animationPeriod: 1, animationOccurenceHandler: animationHandler, width: 110, height: 110) {
                    HapticManager.performFeedbackHaptic(.success)
                    animationHandler = nil
                    presenting = true
                }.fullScreenCover(isPresented: $presenting, onDismiss: {
                    setAnimationHandler()
                    if User.doesExist {
                        viewModel.markUserExists()
                    }
                }, content: {
                    presentee
                })
                Spacer()
            }
            .onAppear {
                setAnimationHandler()
            }
    }
    
    func setAnimationHandler() {
        animationHandler = {
            HapticManager.performBasicHaptic(type: .light)
        }
    }
    
}
