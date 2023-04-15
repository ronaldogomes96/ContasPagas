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
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                
                VStack(spacing: -8) {
                    Text("RS \(viewModel.getTotalExpensesValue().isZero ? "" : "-")\(String(format: "%.2f", viewModel.getTotalExpensesValue()))")
                        .font(.bold(.title)())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(viewModel.getTotalExpensesValue().isZero ? .black : .red)
                    
                    List {
                        ForEach(viewModel.expensesDetails) {
                            FinanceDetailsView(name: $0.name,
                                               date: $0.date,
                                               value: $0.value,
                                               paid: $0.paid)
                        }
                        
                        ForEach(viewModel.expensesType) { expenseType in
                            Section(header: Text(expenseType.name)) {
                                ForEach(expenseType.expenses) {
                                    FinanceDetailsView(name: $0.name,
                                                       date: $0.date,
                                                       value: $0.value,
                                                       paid: $0.paid)
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
                                    NavigationLink(destination: Text("Tela de detalhes")) {
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
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
