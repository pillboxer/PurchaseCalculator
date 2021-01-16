//
//  NewUserView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import SwiftUI
import PurchaseCalculatorDataKit

struct UserPreferencesView: View {
    
    @ObservedObject var model =  UserPreferencesViewModel()
    let textFieldFont = UIFont.boldSystemFont(ofSize: 12)
    
    private var ctaIsDisabled: Bool {
        model.userName.count < model.minimumCharactersInName || model.userTakeHomePay.count < model.minimumDigitsForTakeHomePay || !model.hasChanges
    }
    
    var body: some View {
        EmptorColorSchemeAdaptingView {
            if let error = model.currentErrorMessage {
                Label(error)
                    .padding()
                DismissalButton()
            }
            else if let attributes = model.attributes {
                let currencies = model.currencies.compactMap { $0.symbol }
                
                VStack {
                    ReportTitleView(text: model.titleString)
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
                        .padding(.horizontal)
                    Divider()
                        .padding()
                    UserPreferencesForm(attributes: attributes)
                        .environmentObject(model)
                    UserPreferencesViewCTAsView(disabled: ctaIsDisabled)
                        .environmentObject(model)
                }
                .padding()
            }
        }
    }
}

struct UserPreferencesViewCTAsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: UserPreferencesViewModel
    
    var disabled: Bool
    
    var body: some View {
        HStack(spacing: 32) {
            DismissalButton() {
                model.resetContext()
            }
            CTAButton(text: "save_cta") {
                model.save() {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .disabled(disabled)
        }
    }
    
}
