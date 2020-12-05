//
//  NewUserView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 08/11/2020.
//

import SwiftUI
import Combine

struct UserPreferencesView: View {
    @EnvironmentObject var model: UserPreferencesViewModel
    let textFieldFont = UIFont.boldSystemFont(ofSize: 12)
    @State var selected = 0
    var body: some View {
        if let error = model.currentErrorMessage {
            Text(error)
        }
        else if let questions = model.valuesQuestionnaire {
            let currencies = model.currencies.compactMap { $0.symbol }
            VStack(alignment: .center) {
                Text("Personalise your results")
                    .modifier(StandardFontModifier())
                    .padding()
                TextFieldWithLimitView(placeholder: "What's Your Name",
                                       textFieldText: $model.userName,
                                       minimumCharacters: model.minimumCharactersInName,
                                       font: textFieldFont)
                    .padding()
                NewUserTextFieldWithPicker(selections: currencies,
                                           placeholder: "Enter Your Yearly Take Home Pay",
                                           minimumCharacters: model.minimumDigitsForTakeHomePay,
                                           textFieldText: $model.userTakeHomePay,
                                           selection: $model.selectedCurrencyString,
                                           font: textFieldFont)
                    .padding()
                NewUserValuesForm(questions: questions)
                Button("Save") {
                    model.save()
                }
                .disabled(model.userName.count < model.minimumCharactersInName || model.userTakeHomePay.count < model.minimumDigitsForTakeHomePay)
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
        VStack {
            Text("What's important to you?")
                .modifier(StandardFontModifier())
                .padding()
            ScrollView {
                ForEach(questions) { question in
                    NewUserValueSelection(question: question)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
}

struct NewUserValueSelection: View {
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

struct StepperWithFillingRectangles: View {

    var numberOfRectangles: Int
    var cornerRadiusForRectangles: CGFloat? = nil
    @State var valueToChange: Double
    var changeHandler: (Double) -> Void
    var body: some View {
        HStack {
            ForEach(0..<numberOfRectangles) { index in
                Rectangle()
                    .fill(fillColor(index))
                    .animation(.easeIn)
                    .frame(width: 40, height: 10)
                    .cornerRadius(cornerRadiusForRectangles ?? 0)
                .overlay(RoundedRectangle(cornerRadius: cornerRadiusForRectangles ?? 0).stroke(Color.primary))
                    .gesture(TapGesture().onEnded { UIApplication.endEditing() })

            }
            Spacer()
            Stepper("",
                    onIncrement: {
                        self.valueToChange = min(1, self.valueToChange + 0.1)
                        changeHandler(valueToChange)
                    },
                    onDecrement: {
                        self.valueToChange = max(0, self.valueToChange - 0.1)
                        changeHandler(valueToChange)
                    }
            )
            .frame(height: 20)
        }
    }
    
    func fillColor(_ index: Int) -> Color {
            let valueAsPercentage = valueToChange * 100
            let indexAsPercentageOfAllRectangles = Double(index) / Double(numberOfRectangles) * 100
            return valueAsPercentage >= indexAsPercentageOfAllRectangles ? colorForWeight(valueToChange) : Color(UIColor.systemBackground)
    }
    
    private func colorForWeight(_ weight: Double) -> Color {
        let red = min(0.5, weight)
        let blue = max(0.5, 1-weight)
        let green = max(0.5, weight)
        let color = Color(red: red, green: green, blue: blue, opacity: 1)
        return color
    }
}
