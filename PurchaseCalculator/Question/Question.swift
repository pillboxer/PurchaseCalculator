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
    let subtitle: String?
    let questionOptions: [QuestionOption]?
    let requiresInput: Bool?
    var selectedOption: QuestionOption?
    
    var id: String {
        uuid
    }
    
}
