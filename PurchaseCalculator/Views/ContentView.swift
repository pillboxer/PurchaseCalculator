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
        NavigationView {
            if let questions = provider.questions {
                    PotentialPurchaseFormView(questions: questions)
            }
            else if let error = provider.error ?? QuestionProvider.QuestionProviderError.noQuestionsAvailable {
                Text(error.errorDescription)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if let provider = QuestionProvider() {
            ContentView().environmentObject(provider)
        }
        else {
            ContentView()
        }
    }
}
