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
    let questionIDs: [String]
    let initialScore: Double
    
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
            let json = try JSONDecoder.decodeLocalJSON(file: "Questions", type: [Question].self)
            return json.filter { questionIDs.contains($0.uuid) }
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
