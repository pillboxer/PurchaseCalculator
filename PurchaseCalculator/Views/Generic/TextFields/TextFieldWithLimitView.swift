//
//  TextFieldWithLimitView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import SwiftUI

struct TextFieldWithLimitView: View {
    
    var placeholder: String
    @Binding var textFieldText: String
    var minimumCharacters: Int?
    var font: UIFont?
    var keyboardType: UIKeyboardType?
    var animated: Bool {
        textFieldText.count > 1
    }
    
    var body: some View {
        HStack {
            NoClipboardTextField(placeholder: placeholder, font: font, keyboardType: keyboardType, text: $textFieldText)
            Circle().fill(textFieldText.count >= minimumCharacters ?? 0 ? Color.green : Color.gray)
                .frame(width: 10, height: 10)
        }
    }
}

