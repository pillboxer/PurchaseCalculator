//
//  ExplanationViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//
import Foundation
// FIXME: - Rename
class ExplanationViewModel: ObservableObject {
    
    private var currentContext: ExplanationContext = .elevatorPitch
    
    var labelText: String {
        switch currentContext {
        case .elevatorPitch:
            return "Oliver helps minimise buyer's remorse"
        case .howItWorks:
            return "It measures a product based on seven key attributes"
        case .attribute:
            return selectedAttribute.handle
        case .complete:
            return "Complete"
        }
    }
    
    var imageName: String? {
        switch currentContext {
        case .attribute:
            return selectedAttribute.symbol
        default:
            return nil
        }
    }
    
    private var allAttributes = DecodedObjectProvider.attributes ?? []
    private var selectedAttributeIndex = 0
    
    var selectedAttribute: PurchaseAttribute {
        allAttributes[selectedAttributeIndex]
    }
    
    private enum ExplanationContext: Int {
        
        case elevatorPitch
        case howItWorks
        case attribute
        case complete
        
        var next: ExplanationContext {
            switch self {
            case .elevatorPitch:
                return .howItWorks
            case .howItWorks:
                return .attribute
            default:
                return .complete
            }
        }
    }
    
    func changeContext() {
        if currentContext == .attribute {
            if selectedAttributeIndex == allAttributes.count - 1 {
                currentContext = currentContext.next
            }
            else {
                selectedAttributeIndex += 1
            }
        }
        else {
            currentContext = currentContext.next
        }
        objectWillChange.send()
    }
    
}
