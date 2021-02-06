//
//  CustomUnitCreationView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/01/2021.
//

import SwiftUI

struct CustomUnitCreationView: View {
    
    @ObservedObject private var viewModel: CustomUnitCreationViewModel
    @State private var isPushed = false
    @Binding var isActive: Bool
    
    var item: PurchaseItem
    var initialBrandName: String?
    
    init(item: PurchaseItem, initialBrandName: String? = nil, isActive: Binding<Bool>) {
        self.item = item
        self.viewModel = CustomUnitCreationViewModel()
        self._isActive = isActive
        self.viewModel.brandName = initialBrandName ?? ""
    }
    
    @State private var customUnit: SpecificPurchaseUnit?
    
    @ViewBuilder
    private var destination: some View {
        if let customUnit = customUnit {
            EvaluationUnitConfirmationView(unit: customUnit, item: item, isActive: $isActive)
        }
    }
    
    var body: some View {
        EmptorColorSchemeAdaptingView {
            VStack(spacing: 32) {
                ReportTitleView(text: item.handle, imageName: item.imageName)
                TextFieldWithLimitView(placeholder: placeholderFor("brand"),
                                       textFieldText: $viewModel.brandName,
                                       minimumCharacters: 1,
                                       font: UIFont.boldSystemFont(ofSize: 12))
                    .padding(.horizontal)
                TextFieldWithLimitView(placeholder: placeholderFor("model"),
                                       textFieldText: $viewModel.modelName,
                                       minimumCharacters: 5,
                                       font: UIFont.boldSystemFont(ofSize: 12))
                    .padding(.horizontal)
                TextFieldWithLimitView(placeholder: placeholderFor("cost"),
                                       textFieldText: $viewModel.costString,
                                       minimumCharacters: 2,
                                       font: .boldSystemFont(ofSize: 12),
                                       keyboardType: .decimalPad)
                    .padding(.horizontal)
                Divider()
                    .padding()
                Spacer()
                HStack {
                    DismissalButton()
                        .padding()
                    CTAButton(text: "next_cta") {
                        createUnit()
                        isPushed = true
                    }
                    .disabled(viewModel.buttonIsDisabled)
                }
            }
            .padding()
        }
        HiddenNavigationLink(destination: destination, isActive: $isPushed)

    }
    
    private func placeholderFor(_ string: String) -> String {
        String.forKey("add_your_own_placeholder_\(string)")
    }
    
    private func createUnit() {
        let brandID = DecodedObjectProvider.purchaseBrands?.filter { $0.handle == viewModel.brandName }.first?.uuid ?? UUID().uuidString
        let unit = SpecificPurchaseUnit(uuid: UUID().uuidString, brandID: brandID, modelName: viewModel.modelName, cost: viewModel.cost, evaluationCount: 0)
        customUnit = unit
    }
}
