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
    let subtitle: String?
    let questionOptions: [QuestionOption]?
    let requiresInput: Bool?
    let removeForPremiumMembers: Bool?
    let showForPremiumMembers: Bool?
    var selectedOption: QuestionOption?
    
    var firstOption: QuestionOption? {
        questionOptions?.first
    }
    
    var id: String {
        uuid
    }
    
}
