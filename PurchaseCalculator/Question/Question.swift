//
//  Question.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import Foundation

class Question: Decodable, Identifiable {
    
    let title: String
    let uuid: String
    let attributeID: String?
    
    var id: String {
        uuid
    }
    
}
