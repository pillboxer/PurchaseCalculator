//
//  BackButtonView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct BackButtonView: View {
    var body: some View {
        StackPopButtonWithImageView(imageName: "chevron.backward.square")
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
