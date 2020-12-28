//
//  NewUserView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

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
            PCTextView(error)
        }
        else if let attributes = model.attributes {
            let currencies = model.currencies.compactMap { $0.symbol }
            BasicNavigationView(home: true) {
                VStack {
                    PCTextView(model.titleString)
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
                    UserPreferencesForm(attributes: attributes)
                    BorderedButtonView(text: "Save") {
                        model.save() {
                            row = nil
                        }
                    }
                    .frame(width: 100, height: 30)
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
    
    var attributes: [PurchaseAttribute]

    var body: some View {
        VStack {
            PCTextView(model.listHeaderString)
                .padding(.bottom)
            ScrollView {
                ForEach(attributes, id: \.uuid) { attribute in
                    PurchaseValueWeightingSelectionView(initialValue: model.weightForValue(id: attribute.uuid).to(decimalPlaces: 2), attribute: attribute)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
}

struct PurchaseValueWeightingSelectionView: View {
    @EnvironmentObject var model: UserPreferencesViewModel
    @State var initialValue: Double
    var attribute: PurchaseAttribute
    
    var image: some View {
        Image(attribute.symbol)
            .resizable()
            .frame(width: 20, height: 20)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                image
                PCTextView(attribute.handle)             
            }
            HStack {
                let weighting = AttributeUserWeighting(weight: initialValue)
                StepperWithFillingRectangles(numberOfRectangles: 5, cornerRadiusForRectangles: 2, valueToChange: $initialValue, userWeighting: weighting) { newValue in
                    initialValue = newValue.to(decimalPlaces: 2)
                    model.addAttributeValue(id: attribute.uuid, weight: newValue)
                }
            }
        }
    }
}


