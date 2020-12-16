//
//  NewUserView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import SwiftUI
import Combine

struct UserPreferencesView: FirebaseRefreshingView {
    
    @ObservedObject var firebaseObserved: FirebaseCoordinator = FirebaseCoordinator.shared
    @EnvironmentObject var model: UserPreferencesViewModel
    let textFieldFont = UIFont.boldSystemFont(ofSize: 12)
    
    @Binding var row: String?
    
    private var ctaIsDisabled: Bool {
        model.userName.count < model.minimumCharactersInName || model.userTakeHomePay.count < model.minimumDigitsForTakeHomePay
    }
    
    var body: some View {
        if let error = model.currentErrorMessage {
            Text(error)
        }
        else if let questions = model.valuesQuestionnaire {
            let currencies = model.currencies.compactMap { $0.symbol }
            BasicNavigationView(home: true) {
                VStack {
                    Text(model.titleString)
                        .modifier(StandardFontModifier())
                        .padding()
                    TextFieldWithLimitView(placeholder: model.userNameTextFieldPlaceholder,
                                           textFieldText: $model.userName,
                                           minimumCharacters: model.minimumCharactersInName,
                                           font: textFieldFont)
                        .padding()
                    TextFieldWithSegmentedPickerView(selections: currencies,
                                               placeholder: model.takeHomePayTextFieldPlaceholder,
                                               minimumCharacters: model.minimumDigitsForTakeHomePay,
                                               textFieldText: $model.userTakeHomePay,
                                               selection: $model.selectedCurrencyString,
                                               font: textFieldFont)
                        .padding()
                    UserPreferencesForm(questions: questions)
                    BorderedButtonView(text: "Save") {
                        model.save() {
                            row = nil
                        }
                    }
                    .frame(width: 40, height: 30)
                    .disabled(ctaIsDisabled)
                    .padding()
                }
            }
            .onAppear {
                model.reset()
            }
        }
    }
}

struct UserPreferencesForm: View {
    
    @EnvironmentObject var model: UserPreferencesViewModel
    
    var questions: [Question]

    var body: some View {
        VStack {
            Text(model.listHeaderString)
                .modifier(StandardFontModifier())
                .padding()
            ScrollView {
                ForEach(questions) { question in
                    PurchaseValueWeightingSelectionView(question: question)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
}

struct PurchaseValueWeightingSelectionView: View {
    @EnvironmentObject var model: UserPreferencesViewModel
    
    var question: Question
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.title)
                .modifier(StandardFontModifier())
            HStack {
                StepperWithFillingRectangles(numberOfRectangles: 5, cornerRadiusForRectangles: 2, valueToChange: model.weightForValue(id: question.attributeID)) { newValue in
                    model.addAttributeValue(id: question.attributeID, weight: newValue)
                }
                
            }
        }
    }
}


