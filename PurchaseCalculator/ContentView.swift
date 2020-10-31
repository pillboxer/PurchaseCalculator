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
                let options = question.questionOptions ?? []
                Text(question.title)
                    .padding()
                QuestionOptionsView(options: options)
                Divider()
            }
        }
        .padding()
    }
}

struct QuestionOptionsView: View {
    @EnvironmentObject var provider: QuestionProvider
    var options: [QuestionOption]

    var body: some View {
        HStack {
            ForEach(options) { option in
                Button(action: {
                    provider.select(option: option)
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
