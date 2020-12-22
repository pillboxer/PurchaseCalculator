//
//  UIApplication+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 22/11/2020.
//
#if os(iOS)
import UIKit


public extension UIApplication {
    
    static func endEditing() {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.endEditing(false)
    }

}
#endif
