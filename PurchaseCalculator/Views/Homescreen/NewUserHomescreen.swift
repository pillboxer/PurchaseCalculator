//
//  NewUserHomescreen.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/12/2020.
//

import SwiftUI

struct NoUserHomescreen: Presenter {
        
    @State var presenting: Bool = false
        
    var presentee: some View {
        UserPreferencesView()
    }
    
    var body: some View {
            VStack {
                Spacer()
                CTAButton(text: "add_profile_cta", imageName: "profile", animationPeriod: 1, width: 100, height: 100) {
                    presenting = true
                }.fullScreenCover(isPresented: $presenting, content: {
                    presentee
                })
                Spacer()
            }
    }
    
}
