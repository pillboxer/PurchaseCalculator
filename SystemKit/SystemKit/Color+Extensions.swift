//
//  Color+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 28/12/2020.
//

#if os(iOS)
import SwiftUI
import UIKit
public extension Color {
    
    static var systemBackground: Color {
        Color(UIColor.systemBackground)
    }

}
#endif
