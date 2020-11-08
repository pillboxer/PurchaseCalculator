//
//  NewUserView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import SwiftUI

struct NewUserView: View {
    @EnvironmentObject var model: NewUserDataModel
    var body: some View {
        if let questions = model.valuesQuestionnaire {
            VStack {
                NewUserValuesForm(questions: questions)
                Divider()
                Button("Save") {
                    model.saveNewUser()
                }
            }

        }
    }
}

struct NewUserValuesForm: View {
    var questions: [Question]
    var body: some View {
        ForEach(questions) { question in
            NewUserValueSelection(question: question)
        }
    }
}

struct NewUserValueSelection: View {
    @EnvironmentObject var model: NewUserDataModel
    
    var question: Question
    @State private var weight: Double = 0.5
    var body: some View {
        Form {
            Text(question.title)
            Slider(value: $weight, in: 0...1, step: 0.01).onChange(of: self.weight, perform: { value in
                if let id = question.attributeID {
                    model.purchaseAttributesToWeightsMap[id] = weight
                }
            })
        }
    }
    
}
