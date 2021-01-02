//
//  String+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 23/12/2020.
//

#if os(iOS)
import UIKit

public extension String {
    
    var existsAsImage: Bool {
        UIImage(named: self) != nil
    }
    
}
#endif
