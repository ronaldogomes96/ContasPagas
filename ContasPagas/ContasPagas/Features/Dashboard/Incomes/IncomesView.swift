//
//  IncomesView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 15/04/23.
//

import SwiftUI

struct IncomesView: View {
    @StateObject var viewModel = IncomesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                
                VStack(spacing: -8) {
                    Text("RS \(String(format: "%.2f", viewModel.getTotalIncomesValue()))")
                        .font(.bold(.title)())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(viewModel.getTotalIncomesValue().isZero ? .black : .green)
                    
                    List {
                        ForEach(viewModel.incomesDetails) {
                            FinanceDetailsView(name: $0.name,
                                               date: $0.date,
                                               value: $0.value,
                                               paid: nil)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationBarTitle("Receitas")
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
            viewModel.fetchIncomes()
        }
    }
    
    @ViewBuilder private func buildTradeView(type: TradeType) -> some View {
        let viewModel = TradeViewModel(tradeType: type,
                                       financeType: .income)
        TradeView(viewModel: viewModel)
    }
}

struct IncomesView_Previews: PreviewProvider {
    static var previews: some View {
        IncomesView()
    }
}