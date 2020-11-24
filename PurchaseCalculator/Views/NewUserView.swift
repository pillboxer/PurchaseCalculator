//
//  NewUserView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import SwiftUI
import Combine

struct NewUserView: View {
    @EnvironmentObject var model: NewUserViewModel
    let textFieldFont = UIFont.boldSystemFont(ofSize: 12)
    @State var selected = 0
    var body: some View {
        if let error = model.currentErrorMessage {
            Text(error)
        }
        else if let questions = model.valuesQuestionnaire {
            let currencies = model.currencies.compactMap { $0.symbol }
                VStack {
                    Spacer()
                    Text("Let's Get Some Details From You To Personalise Your Results")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .padding()
                    TextFieldWithLimitView(placeholder: "What's Your Name",
                                           textFieldText: $model.newUserName,
                                           minimumCharacters: model.minimumCharactersInName,
                                           font: textFieldFont)
                        .padding()
                    NewUserTextFieldWithPicker(selections: currencies,
                                               placeholder: "Enter Your Yearly Take Home Pay",
                                               minimumCharacters: model.minimumDigitsForTakeHomePay,
                                               textFieldText: $model.newUserTakeHomePay,
                                               selection: $model.selectedCurrencyString,
                                               font: textFieldFont)
                        .padding()
                    NewUserValuesForm(questions: questions)
                        .onTapGesture {
                            UIApplication.endEditing()
                        }
                    Button("Save") {
                        model.saveNewUser()
                    }
                    .disabled(model.newUserName.count < model.minimumCharactersInName || model.newUserTakeHomePay.count < model.minimumDigitsForTakeHomePay)
                    .alert(isPresented: $model.showAlert) {
                        Alert(title: Text("Error"), message: Text(model.currentAlertMessage), dismissButton: .default(Text("OK"), action: {
                            model.showAlert = false
                        }))
                    }
                    .padding()
                }
            }
    }
}


struct NewUserTextFieldWithPicker: View {
    
    var selections: [String]
    var placeholder: String
    var minimumCharacters: Int?
    @Binding var textFieldText: String
    @Binding var selection: String
    @State private var textFieldValue: String = ""
    var font: UIFont

    
    var body: some View {
        HStack {
            TextFieldWithLimitView(placeholder: placeholder,
                                   textFieldText: $textFieldText,
                                   minimumCharacters: minimumCharacters,
                                   font: font,
                                   keyboardType: .numberPad)
            Picker("", selection: $selection) {
                ForEach(0..<selections.count)  { index in
                    Text(self.selections[index]).tag(self.selections[index])
                }
            }
            .frame(width: 80, height: 25)
            .clipped()
            .pickerStyle(SegmentedPickerStyle())
            .cornerRadius(8)
        }
    }
}

struct TextFieldWithLimitView: View {
    
    var placeholder: String
    @Binding var textFieldText: String
    var minimumCharacters: Int?
    var font: UIFont?
    var keyboardType: UIKeyboardType?
    var animated: Bool {
        textFieldText.count > 1
    }
    
    var body: some View {
        HStack {
            NoClipboardTextField(placeholder: placeholder, font: font, keyboardType: keyboardType, text: $textFieldText)
            Circle().fill(textFieldText.count >= minimumCharacters ?? 0 ? Color.green : Color.gray)
                .animation(animated ? .easeIn : .none)
                .fixedSize()
        }
    }
}

struct NewUserValuesForm: View {
    var questions: [Question]
    
    init(questions: [Question]) {
        self.questions = questions
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    var body: some View {
        Form {
            ForEach(questions) { question in
                NewUserValueSelection(question: question)
            }
        }
        
    }
}

struct NewUserValueSelection: View {
    @EnvironmentObject var model: NewUserViewModel
    
    init(question: Question) {
        self.question = question
        UITableView.appearance().backgroundColor = .clear
    }
    
    var question: Question
    @State private var weight: Double = 0.5
    var body: some View {
        Text(question.title)
        Slider(value: $weight, in: 0...1, step: 0.01).onChange(of: self.weight, perform: { value in
            if let id = question.attributeID {
                model.purchaseAttributesToWeightsMap[id] = weight
            }
        })
        .accentColor(colorForWeight(weight))
    }
    
    private func colorForWeight(_ weight: Double) -> Color {
        // FIXME
        let color = Color(red: 0.5, green: weight-0, blue: 1-weight, opacity: 1)
        print(color)
        return color
    }
}
