//
//  ExplanationViewModel.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/12/2020.
//
import Foundation
// FIXME: - Rename
class ExplanationViewModel: ObservableObject {
    
    enum ExplanationContext: Int {
        
        case elevatorPitch
        case attribute
        case complete
        
        var next: ExplanationContext {
            switch self {
            case .elevatorPitch:
                return .attribute
            default:
                return .complete
            }
        }
    }
    
    @Published var currentContext: ExplanationContext = .elevatorPitch
    
    // MARK: - Private
    private var allAttributes = DecodedObjectProvider.attributes() ?? []
    @Published private var selectedAttributeIndex = 0
    private var selectedExplanationIndex = 0
    private var selectedAttribute: PurchaseAttribute {
        allAttributes[selectedAttributeIndex]
    }
    
    // FIXME: - Strings
    private var explanationStrings: [String] {
        ["Emptor helps minimise buyer's remorse",
         "It measures a product based on \(allAttributes.count) key attributes",
         "And provides purchasing advice based on what's meaningful to you",
         "Those attributes are:"]
    }
    
    // MARK: - Top Row Of Icons
    var showsIconGroupDisplay: Bool {
        currentContext != .elevatorPitch
    }
    
    var topIndexDisplayed: Int {
        showsDetailedDescriptions ? allAttributes.count - 1 : selectedAttributeIndex
    }
    
    var iconNames: [String] {
        allAttributes.compactMap { $0.symbol }
    }
    
    var iconsSubheaderText: String {
        "Select an icon to learn more"
    }
    
    // MARK: - Detailed Descriptions
    var showsDetailedDescriptions: Bool {
        currentContext == .complete
    }
    
    func updateSelectedAttributeIndex(_ index: Int) {
        selectedAttributeIndex = index
    }
    
    var detailedDescriptionTitle: String {
        selectedAttribute.handle
    }
    
    var detailedDescriptionImageName: String {
        iconNames[selectedAttributeIndex]
    }
    
    var detailedDescription: String {
        let desc = allAttributes[selectedAttributeIndex].description
        return desc
    }
    
    // MARK: - Pulsing View
    var labelText: String {
        switch currentContext {
        case .elevatorPitch:
            return explanationStrings[selectedExplanationIndex]
        default:
            return selectedAttribute.handle
        }
    }
    
    var pulsingImageName: String? {
        switch currentContext {
        case .attribute:
            return selectedAttribute.symbol
        default:
            return nil
        }
    }
    
    var pulsingDuration: Double {
        if currentContext == .elevatorPitch {
            return 4
        }
        if currentContext == .attribute {
            return 1
        }
        return 0
    }
    
    var showsPulsingView: Bool {
        currentContext != .complete
    }
    
    // MARK: - CTA
    var showsCTA: Bool {
        currentContext == .complete
    }
    
    // MARK: - Exposed
    func reset() {
        currentContext = .elevatorPitch
        selectedAttributeIndex = 0
        selectedExplanationIndex = 0
        objectWillChange.send()
    }
    
    func changeContext() {
        
        if currentContext == .elevatorPitch {
            if selectedExplanationIndex == explanationStrings.count - 1{
                currentContext = currentContext.next
            }
            else {
                selectedExplanationIndex += 1
            }
        }
        
        else if currentContext == .attribute {
            if selectedAttributeIndex == allAttributes.count - 1 {
                currentContext = currentContext.next
                selectedAttributeIndex = 0
            }
            else {
                selectedAttributeIndex += 1
            }
        }
    }
    
}
