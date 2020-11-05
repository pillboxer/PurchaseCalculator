//
//  QuestionProvider.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SystemKit

class QuestionProvider: ObservableObject {
    
    enum QuestionProviderError: LocalizedError {
        case providerError(Int)
        case noQuestionsAvailable
        
        var errorDescription: String {
            switch self {
            case .providerError(let code):
                return "Can't Display Question. Code: \(code)"
            case .noQuestionsAvailable:
                return "No Questions Available"
            }
        }
    }
    
    @Published var questions: [Question]?
    private var currentQuestion: Question?
    private var calculator: Calculator?
    @Published var currentScore = 0.0
    @Published var error: QuestionProviderError?
    
    init() {
        do {
            let categories = try QuestionCategory.decodeLocal()
            guard let category = categories.first else {
                error = .noQuestionsAvailable
                return
            }
            let questions = try category.questions()
            calculator = Calculator(initialScore: category.initialScore)
            self.questions = questions
        }
        catch let error {
            let code = (error as? SystemKitError)?.code ?? 999
            self.error = .providerError(code)
        }
    }
    
    private func deselectCurrentOption() {
        if let option = currentQuestion?.selectedOption {
            calculator?.deselectOption(option)
        }
    }
    
    func select(option: QuestionOption, question: Question) {
        currentQuestion = question
        deselectCurrentOption()
        currentQuestion?.selectedOption = option

        calculator?.selectOption(option)
        currentScore = calculator!.score
    }
    
}
