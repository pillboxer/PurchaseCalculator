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
    // MARK: - New User
    func testNewUserViewModelValuesQuestionnaireReturns() {
        let viewModel = NewUserViewModel()
        let questionnaire = viewModel.valuesQuestionnaire
        XCTAssertNotNil(questionnaire)
    }
    
    // MARK: - Evaluation
    func testEvaluationViewModelPurchaseCategoriesReturn() {
        let viewModel = PurchaseEvaluationViewModel()
        let attributes = viewModel.purchaseCategories
        XCTAssertNotNil(attributes)
    }
    
    func testEvaluationManagerReturnsEvaluationForPurchaseItem() {
        // FIXME: - 
    }
    
}
