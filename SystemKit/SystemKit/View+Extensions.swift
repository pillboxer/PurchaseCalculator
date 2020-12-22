//
//  View+Extensions.swift
//  SystemKit
//
//  Created by Henry Cooper on 16/12/2020.
//

import SwiftUI

public extension View {
    
    var name: String {
        String(describing: self).components(separatedBy: "(").first ?? String(describing: self)
    }

}
