//
//  PotentialPurchaseListView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 06/11/2020.
//

import SwiftUI

struct PotentialPurchaseListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FetchRequest(entity: PotentialPurchase.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PotentialPurchase.dateCreated, ascending: false)]) var purchases: FetchedResults<PotentialPurchase>
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    var latestResult: String
    var body: some View {
        VStack {
            Text("Based on your responses, we recommend:")
                .multilineTextAlignment(.center)
                .padding()
            Text(latestResult)
                .font(Font.subheadline.bold())
                .padding()
            Button("Go Back") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }.padding()
        List {
            Section(header: Text("Past Responses")) {
                ForEach(purchases) { (purchase: PotentialPurchase) in
                    let title = purchase.title ?? ""
                    let subtitle = purchase.resultAdvice ?? ""
                    let date = formatter.string(from: purchase.dateCreated ?? Date())
                    PastResponseView(title: title, subtitle: subtitle, date: date)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
}

struct PastResponseView: View {
    var title: String
    var subtitle: String
    var date: String
    
    var body: some View {
        Text(title)
            .font(Font.subheadline.bold())
        HStack {
            Text(subtitle)
                .font(.subheadline)
            Spacer()
            Text(date)
                .font(.subheadline)
        }
    }
    
}
