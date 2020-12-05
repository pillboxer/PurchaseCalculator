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
    
    let coreDataManager = CoreDataManager.shared
    
    var testUser: User?
    
    override func setUpWithError() throws {
        createTestUser()
    }
    
    private func createTestUser() {
        let viewModel = UserPreferencesViewModel()
        let questions = viewModel.valuesQuestionnaire ?? []
        let context = coreDataManager.moc
        let user = User(context: context)
        user.takeHomePay = NSNumber(floatLiteral: 50000)
        user.name = "Test User"
        for question in questions {
            let id = question.attributeID
            let value = PurchaseAttributeValue(context: context)
            value.attributeID = id
            value.weight = 0.5
            user.addToPurchaseValues(value)
        }
        testUser = user
        coreDataManager.save(context)
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
        let viewModel = UserPreferencesViewModel()
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
        let smartphoneUUID = "97159302-c33b-4804-951b-6d439e9d3b9a"
        let smartphoneHandle = "Smart Phone"
        let smartphoneAttributeGroupID = "b2ae2961-5bb4-4185-9d8d-e2199986541c"
        let item = PurchaseItem(uuid: smartphoneUUID, itemHandle: smartphoneHandle, attributeMultiplierGroupID: smartphoneAttributeGroupID)
        let evaluationManager = EvaluationManager(user: testUser)
        evaluationManager?.evaluate(item, costing: 1000)
        XCTAssertNotNil(evaluationManager?.evaluationResult)
    }
    
}
