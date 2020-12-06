//
//  KeyboardListener.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/12/2020.
//

import Foundation
import UIKit

class KeyboardListener {
    
    static private(set) var keyboardIsShowing = false
    
    static func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc static func keyboardWillAppear() {
        keyboardIsShowing = true
    }
    
    @objc static func keyboardWillDisappear() {
        keyboardIsShowing = false
    }
}
