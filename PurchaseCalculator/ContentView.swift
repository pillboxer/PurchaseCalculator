//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var provider: QuestionProvider
    
    var body: some View {
        if let questions = provider.questions {
            Text("\(provider.currentScore)")
            QuestionsView(questions: questions)
        }
        else if let error = provider.error ?? QuestionProvider.QuestionProviderError.noQuestionsAvailable {
            Text(error.errorDescription)
        }
    }
}

struct QuestionsView: View {
    var questions: [Question]
    var body: some View {
        VStack {
            ForEach(questions) { question in
                Text(question.title)
                    .padding()
                QuestionOptionsView(question: question)
                Divider()
            }
        }
        .padding()
    }
}

struct QuestionOptionsView: View {
    @EnvironmentObject var provider: QuestionProvider
    var question: Question

    var body: some View {
        HStack {
            let options = question.questionOptions ?? []
            ForEach(options) { option in
                Button(action: {
                    provider.select(option: option, question: question)
                }) {
                    Text(option.title)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
