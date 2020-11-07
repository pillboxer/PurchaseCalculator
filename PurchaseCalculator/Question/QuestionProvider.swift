//
//  QuestionProvider.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SystemKit
import Combine

class QuestionProvider: ObservableObject {
    
    var cancellable: AnyCancellable?
    
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
    
    // MARK: - Published
    @Published var questions: [Question]?
    @Published var currentScore = 0.0
    @Published var error: QuestionProviderError?
    
    private var category: QuestionCategory
    private var currentQuestion: Question?
    private var calculator: Calculator
    
    var thresholdDescription: String {
        let results = category.resultAdvice.sorted { $0.threshold < $1.threshold }
        for result in results {
            if currentScore < result.threshold {
                return result.title
            }
        }
        return results.last?.title ?? "Could Not Get Result"
    }
    
    init?() {
        do {
            let categories = try QuestionCategory.decodeLocal()
            guard let first = categories.first else {
                error = .noQuestionsAvailable
                return nil
            }
            self.category = first
            let questions = try category.questions()
            self.questions = questions
            calculator = Calculator(initialScore: category.initialScore)
            startObservingCalculator()
        }
        catch let error {
            let sysError = (error as? SystemKitError)
            let code = sysError?.code ?? 999
            self.error = .providerError(code)
            return nil
        }
    }
    
    private func deselectCurrentOption() {
        if let option = currentQuestion?.selectedOption {
            calculator.deselectOption(option)
        }
    }
    
    func select(option: QuestionOption, question: Question) {
        currentQuestion = question
        deselectCurrentOption()
        currentQuestion?.selectedOption = option

        calculator.selectOption(option)
        currentScore = calculator.score
    }
    
    func reset() {
        questions?.forEach { $0.selectedOption = nil }
        currentScore = 0
        
    }
    
}


// MARK: - Providing Observation
extension QuestionProvider {
    
    private func startObservingCalculator() {
        cancellable = calculator.objectWillChange.sink(receiveValue: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.currentScore = strongSelf.calculator.score
        })
    }

}
