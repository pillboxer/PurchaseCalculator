//
//  PurchaseCalculatorTests.swift
//  PurchaseCalculatorTests
//
//  Created by Henry Cooper on 31/10/2020.
//

import XCTest
import SystemKit
@testable import PurchaseCalculator

class PurchaseCalculatorTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func failWithError(_ error: Error) {
        if let error = error as? SystemKitError {
            XCTFail(error.errorDescription)
        }
        else {
            XCTFail(error.localizedDescription)
        }
    }

    func testCanDecodeLocalJSON() {
        do {
            let json = try JSONDecoder.decodeLocalJSON(file: "Questions", type: [Question].self)
            print(json)
        }
        catch let error {
            failWithError(error)
        }
    }
    
    func testCanAccessQuestionsAfterDecodingQuestionCategoryJSON() {
        do {
            let categories = try QuestionCategory.decodeLocal()
            XCTAssertNotNil(categories.first?.questions)
        }
        catch let error {
            failWithError(error)
        }
    }
    
    func testCalculatorScoreIsAdjustedCorrectlyOnOptionSelection() {
        do {
            let categories = try QuestionCategory.decodeLocal()
            if let category = categories.first,
               let option = category.firstQuestion?.firstOption {
                let calculator = Calculator(initialScore: category.initialScore)
                calculator.selectOption(option)
                XCTAssertEqual(10.5, calculator.score)
            }
            else {
                XCTFail()
            }
        }
        catch let error {
            failWithError(error)
        }
    }

}
