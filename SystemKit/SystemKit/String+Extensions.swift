//
//  String+Extensions.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 03/01/2021.
//

import UIKit
#if os(iOS)
public extension String {
    
    var existsAsImage: Bool {
        UIImage(named: self) != nil
    }
    
}
#endif
