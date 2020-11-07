//
//  QuestionCategory.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SystemKit

class QuestionCategory: Decodable {
    
    let title: String
    let uuid: String
    let questionGroupID: String
    let initialScore: Double
    let resultAdvice: [ResultAdvice]
    
    static func decodeLocal() throws -> [QuestionCategory] {
        do {
            return try JSONDecoder.decodeLocalJSON(file: "QuestionCategories", type: [QuestionCategory].self)
        }
        catch {
            throw error
        }
    }
    
    func questions() throws -> [Question] {
        do {
            let groupsJSON = try JSONDecoder.decodeLocalJSON(file: "QuestionGroups", type: [QuestionGroup].self)
            let questionsJSON = try JSONDecoder.decodeLocalJSON(file: "Questions", type: [Question].self)
            let matchingGroupIDs = groupsJSON.filter { questionGroupID == $0.uuid }.first?.questionIDs ?? []
            return questionsJSON.filter { matchingGroupIDs.contains($0.uuid) }
            
        }
        catch  {
            throw error
        }
    }
    
    func firstQuestion() throws -> Question? {
        do {
            return try questions().first
        }
        catch {
            throw error
        }
    }
    
}

struct ResultAdvice: Decodable {
    let title: String
    let threshold: Double
}
