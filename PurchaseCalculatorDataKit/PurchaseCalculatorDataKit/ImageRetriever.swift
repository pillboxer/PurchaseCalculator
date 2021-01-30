//
//  ImageRetriever.swift
//  PurchaseCalculatorDataKit
//
//  Created by Henry Cooper on 25/01/2021.
//

import Foundation
import SwiftUI
import SystemKit

public class ImageRetriever {
    
    public static func image(named name: String?, default defaultImage: String? = nil) -> UIImage? {
        guard let name = name else {
            return nil
        }
        
        if let image = FileManager.default.imageFromLibrary(file: name, folder: "Emptor/Assets") {
            return image
        }
        else if let image = UIImage(named: name) {
            return image
        }
        else if let defaultImage = defaultImage,
                let image = UIImage(named: defaultImage) {
          return image
        }
        return nil
    }
    
}
