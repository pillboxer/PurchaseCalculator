//
//  CustomUnitCreationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/01/2021.
//

import SwiftUI

struct CustomUnitCreationView: View {
    
    var item: PurchaseItem
    @State var brandName: String = ""
    
    var body: some View {
        VStack {
            Image(named: item.imageName)
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            TextFieldWithLimitView(placeholder: "Brand",
                                   textFieldText: $brandName,
                                   minimumCharacters: 5,
                                   font: UIFont.boldSystemFont(ofSize: 12))
            Spacer()
        }
        .padding()
    }
}
