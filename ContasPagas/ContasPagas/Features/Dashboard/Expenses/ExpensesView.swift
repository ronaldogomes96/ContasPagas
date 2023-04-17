//
//  ExpensesView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import SwiftUI

struct ExpensesView: View {
    @StateObject var viewModel = ExpensesViewModel()
    
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
            .navigationBarTitle("Despesas")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: buildTradeView(type: .add)) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.blue)
                }
            )
        }
        .onAppear {
            viewModel.fecthExpenses()
        }
    }
    
    @ViewBuilder private func buildTradeView(type: TradeType) -> some View {
        let viewModel = TradeViewModel(tradeType: type,
                                       financeType: .expense)
        TradeView(viewModel: viewModel)
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
