//
//  EvaluationReportView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 27/12/2020.
//

import SwiftUI

struct EvaluationReportView: View {
    
    var evaluation: EvaluationManager.Evaluation
    
    var penaltyText: String {
        evaluation.penaltyApplied ? "YES" : "NO"
    }
    
    var penaltyColor: Color {
        evaluation.penaltyApplied ? .red : .primary
    }
    
    @State private var inspectionRowShowing = false
    
    private func toggleInspectionRowShowing() {
        withAnimation(.linear(duration: 0.1)) { inspectionRowShowing.toggle() }
    }
    
    private func hideInspectionRow() {
        withAnimation(.linear(duration: 0.1)) { inspectionRowShowing = false }
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            EvaluationReportTitleView()
                .padding(.top)
            ReportRowView(title: "Cost", value: PriceFormatter.format(cost: evaluation.unitCost), imageName: "money")
            ReportRowView(title: "High THP penalty", value: penaltyText, valueColor: penaltyColor, imageName: "gavel", inspectionHandler: toggleInspectionRowShowing)
            if inspectionRowShowing {
                InspectionRowView(closeHandler: hideInspectionRow, text: "Applied if the cost is high relative to take home pay")
            }
            ReportRowView(title: "Alignment with values", value: evaluation.alignmentPercentageString, imageName: "regret")
            ReportRowView(title: "Reason to buy", value: evaluation.reasonToBuy?.attributeName ?? "", imageName: evaluation.reasonToBuy?.attributeImageName ?? "")
            ReportRowView(title: "Reason to avoid", value: evaluation.reasonToAvoid?.attributeName ?? "", imageName: evaluation.reasonToAvoid?.attributeImageName ?? "")
            ReportRowView(title: "Result", value: evaluation.result.description, imageName: "decision")
        }
    }
    
}

struct EvaluationReportTitleView: View {
    
    var body: some View {
        HStack {
            Divider().padding(.leading)
            PCTextView("Your result").padding(.horizontal)
                .layoutPriority(.greatestFiniteMagnitude)
            Divider().padding(.trailing)
        }
    }
}

struct InspectionRowView: View {
    
    var closeHandler: () -> Void
    var text: String
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.systemBackground)
                .frame(width: 25, height: 25)
            PCTextView(text, size: 10)
                .padding(.horizontal)
                .frame(height: 40)
            Spacer()
            BorderedButtonView(text: "OK", action: closeHandler)
                .frame(width: 40, height: 25)
        }
        .padding(.horizontal)
        .onTapGesture {
            closeHandler()
        }
    }
}

struct ReportRowView: View {
    
    var title: String
    var value: String
    var valueColor: Color?
    var imageName: String
    var inspectionHandler: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 25, height: 25)
            PCTextView(title)
                .padding(.leading)
            if let inspectionHandler = inspectionHandler {
                Image("question")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        inspectionHandler()
                    }
            }
            Spacer()
            PCTextView(value)
                .foregroundColor(valueColor)
        }
        .padding(.horizontal)
    }
    
}
