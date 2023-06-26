//
//  ExpensesView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import SwiftUI

struct ExpensesView: View {
    @StateObject private var viewModel: ExpensesViewModel
    private let viewFactory: ViewFactory
    
    init(viewModel: ExpensesViewModel,
         viewFactory: ViewFactory) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                
                VStack(spacing: -8) {
                    Text("RS \(viewModel.getTotalExpensesValue().isZero ? "" : "-")\(String(format: "%.2f", viewModel.getTotalExpensesValue()))")
                        .font(.bold(.title)())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(viewModel.getTotalExpensesValue().isZero ? .black : .red)
                    
                    List {
                        ForEach(viewModel.expensesDetails) { expense in
                            NavigationLink(destination: buildTradeView(type: .edit)) {
                                FinanceDetailsView(name: expense.name,
                                                   date: expense.date,
                                                   value: expense.value,
                                                   paid: expense.paid)
                            }
                        }
                        
                        ForEach(viewModel.expensesType) { expenseType in
                            Section(header: Text(expenseType.name)) {
                                ForEach(expenseType.expenses) { expense in
                                    NavigationLink(destination: buildTradeView(type: .edit)) {
                                        FinanceDetailsView(name: expense.name,
                                                           date: expense.date,
                                                           value: expense.value,
                                                           paid: expense.paid)
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationBarTitle(LocalizableStrings.tabbarExpense.localized)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: viewFactory.makeTradeView(tradeType: .add,
                                                                                          financeType: .expense,
                                                                                          financeName: "",
                                                                                          financeTypeName: "",
                                                                                          tradeValue: "",
                                                                                          selectedDate: Date(),
                                                                                          isPaid: false)) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.blue)
                }
            )
        }
        .task {
            await viewModel.fecthExpenses()
        }
    }
    
    @ViewBuilder private func buildTradeView(type: TradeType) -> some View {
        let viewModel = TradeViewModel(tradeType: type,
                                       financeType: .expense,
                                       incomeUseCase: IncomeUseCase(repository: RepositoryManager()),
                                       expensesUseCase: ExpenseUseCase(repository: RepositoryManager()))
        TradeView(viewModel: viewModel)
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(viewModel: ExpensesViewModel(expenseUseCase: ExpenseUseCase(repository: RepositoryManager.shared),
                                                  expenseTypeUseCase: ExpensesTypeUseCase(repository: RepositoryManager.shared)), viewFactory: ViewFactory(viewModelFactory: ViewModelFactory()))
    }
}
