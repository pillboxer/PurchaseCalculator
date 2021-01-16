//
//  EvaluationReportView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 27/12/2020.
//

import SwiftUI

struct EvaluationReportView: View {
    
    var evaluation: Evaluation
    
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
            ReportTitleView(text: "evaluation_report_title")
                .padding(.top)
            ReportRowView(title: "report_row_title_0", value: PriceFormatter.format(cost: evaluation.unitCost), imageWrapper: ImageWrapper(name: "money"))
            ReportRowView(title: "report_row_title_1", value: penaltyText, valueColor: penaltyColor, imageWrapper: ImageWrapper(name: "gavel"), inspectionHandler: toggleInspectionRowShowing)
            if inspectionRowShowing {
                InspectionRowView(closeHandler: hideInspectionRow, text: "report_row_1_inspection_text")
            }
            ReportRowView(title: "report_row_title_2", value: evaluation.alignmentPercentageString, imageWrapper: ImageWrapper(name: "regret"))
            ReportRowView(title: "report_row_title_3", value: evaluation.reasonToBuy?.attributeName ?? "", imageWrapper: ImageWrapper(name: evaluation.reasonToBuy?.attributeImageName ?? ""))
            ReportRowView(title: "report_row_title_4", value: evaluation.reasonToAvoid?.attributeName ?? "", imageWrapper: ImageWrapper(name: evaluation.reasonToAvoid?.attributeImageName ?? ""))
            ReportRowView(title: "report_row_title_5", value: evaluation.result.description, imageWrapper: ImageWrapper(name: "decision"))
        }
    }
    
}
