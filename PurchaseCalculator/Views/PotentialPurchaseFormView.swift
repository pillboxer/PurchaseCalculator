//
//  PotentialPurchaseFormView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/11/2020.
//

import SwiftUI

struct PotentialPurchaseFormView: View {
    @EnvironmentObject var provider: QuestionProvider
    @Environment(\.managedObjectContext) var managedObjectContext
    var questions: [Question]
    @State var shouldPush = false
    @State var purchaseName: String = "" 
    
    var formShouldBeDisabled: Bool {
        purchaseName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    @State var latestResult = ""
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Enter Your Purchase Name", text: $purchaseName, onCommit:  {
                        hideKeyboard()
                    })
                        .padding()
                    .onChange(of: self.purchaseName) { _ in
                        if formShouldBeDisabled {
                            provider.reset()
                        }
                    }
                }
                QuestionsView(questions: questions, disabled: formShouldBeDisabled)
                Section {
                    HStack {
                        Spacer()
                            Button("Reveal Answer") {
                                self.saveNewPotentialPurchase()
                                shouldPush.toggle()
                            }
                            .disabled(formShouldBeDisabled || !hasMadeAllChoices)
                        Spacer()
                    }
                }
            }
            NavigationLink(destination: PotentialPurchaseListView(latestResult: latestResult), isActive: $shouldPush, label: {
                EmptyView()
            })
        }
        .navigationTitle("Calculator")
    }
    
    func saveNewPotentialPurchase() {
        let purchase = PotentialPurchase(context: managedObjectContext)
        purchase.dateCreated = Date()
        purchase.resultAdvice = provider.thresholdDescription
        latestResult = provider.thresholdDescription
        purchase.title = purchaseName
        try? managedObjectContext.save()
        purchaseName = ""
        provider.reset()
    }
}

extension PotentialPurchaseFormView {
    
    var hasMadeAllChoices: Bool {
        let questionsWithSelections = questions.filter { $0.selectedOption != nil }
        return questions.count == questionsWithSelections.count
    }
}

struct QuestionsView: View {
    var questions: [Question]
    var disabled: Bool
    var body: some View {
        ForEach(questions) { question in
            Text(question.title)
                .font(.subheadline)
                .padding()
            QuestionOptionsView(question: question, disabled: disabled)
        }
    }
}

struct QuestionOptionsView: View {
    @EnvironmentObject var provider: QuestionProvider
    var question: Question
    var disabled: Bool
    
    var body: some View {
        
        HStack {
            let options = question.questionOptions ?? []
            ForEach(options) { option in
                let optionIsSelected = question.selectedOption == option
                Spacer()
                Button(option.title, action: {
                    print(option.title)
                    provider.select(option: option, question: question)
                })
                .font(Font.headline.weight(.semibold))
                .disabled(optionIsSelected)
                .foregroundColor(optionIsSelected ? .green :  disabled ? .gray : .blue)
                .buttonStyle(BorderlessButtonStyle())
            }
            Spacer()
        }
    }
}
