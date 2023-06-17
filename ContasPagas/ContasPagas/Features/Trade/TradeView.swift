//
//  TradeView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import SwiftUI

struct TradeView: View {
    @ObservedObject var viewModel: TradeViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var isPaied: Bool = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                
                VStack(spacing: 24) {
                    TextField(LocalizableStrings.tradeFinanceType.localized,
                              text: $viewModel.financeTypeName)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)
                    
                    TextField(LocalizableStrings.tradeFinanceName.localized,
                              text: $viewModel.financeName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField(LocalizableStrings.tradeFinanceValue.localized,
                              text: $viewModel.tradeValue)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                    
                    DatePicker(LocalizableStrings.tradeFinanceDate.localized,
                               selection: $viewModel.selectedDate,
                               displayedComponents: [.date])
                    
                    if viewModel.financeType == .expense {
                        Toggle(LocalizableStrings.tradeToglePayed.localized,
                               isOn: $isPaied)
                    }
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(LocalizableStrings.tradeAlertTitle.localized),
                          message: Text(LocalizableStrings.tradeAlertMessage.localized),
                          dismissButton: .default(
                            Text(LocalizableStrings.tradeDismissButton.localized)))
                }
            }
            .navigationBarTitle("\(viewModel.tradeType.titleName) \(viewModel.financeType.rawValue)")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button(LocalizableStrings.tradeSavenButton.localized) {
                    Task {
                        if await viewModel.saveTradeWithSuccess() {
                            dismiss()
                        } else {
                            showAlert = true
                        }
                    }
                }
            }
        }
    }
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView(viewModel: TradeViewModel(tradeType: .edit,
                                            financeType: .income,
                                            incomeUseCase: IncomeUseCase(repository: RepositoryManager()),
                                            expensesUseCase: ExpenseUseCase(repository: RepositoryManager())))
    }
}
