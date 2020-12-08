//
//  UIViewRepresentables.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 22/11/2020.
//

import SwiftUI
import UIKit
import Foundation

struct NoClipboardTextField: UIViewRepresentable {
    
    var placeholder: String
    var font: UIFont?
    var keyboardType: UIKeyboardType?
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = NoPasteTextFieldObject()
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.font = font
        textField.setContentHuggingPriority(.required, for: .vertical) // Don't stretch me
        textField.keyboardType = keyboardType ?? .alphabet
        textField.autocorrectionType = .no
        return textField
    }
    
    func makeCoordinator() -> NoPasteTextFieldCoordinator {
        NoPasteTextFieldCoordinator(self)
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

private class NoPasteTextFieldObject: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
    
}

class NoPasteTextFieldCoordinator: NSObject, UITextFieldDelegate {
    
    var textField: NoClipboardTextField
    
    init(_ textField: NoClipboardTextField) {
        self.textField = textField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.textField.text = textField.text ?? ""
    }
    


}
