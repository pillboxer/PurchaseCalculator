//
//  TextFieldWithSegmentedPickerView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct TextFieldWithSegmentedPickerView: View {
    
    var selections: [String]
    var placeholder: String
    var minimumCharacters: Int?
    @Binding var textFieldText: String
    @Binding var selection: String
    @State private var textFieldValue: String = ""
    var font: UIFont
    
    var body: some View {
        HStack {
            TextFieldWithLimitView(placeholder: placeholder,
                                   textFieldText: $textFieldText,
                                   minimumCharacters: minimumCharacters,
                                   font: font,
                                   keyboardType: .numberPad)
            Picker("", selection: $selection) {
                ForEach(0..<selections.count)  { index in
                    Text(self.selections[index]).tag(self.selections[index])
                }
            }
            .frame(width: 80, height: 25)
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
