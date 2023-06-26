//
//  IncomesView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 15/04/23.
//

import SwiftUI

struct IncomesView: View {
    @StateObject private var viewModel: IncomesViewModel
    private let viewFactory: ViewFactory
    
    init(viewModel: IncomesViewModel,
         viewFactory: ViewFactory) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.viewFactory = viewFactory
    }
    
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
            .navigationBarTitle(LocalizableStrings.tabbarEarnings.localized)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: viewFactory.makeTradeView(tradeType: .add,
                                                                                          financeType: .income,
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
            await viewModel.fetchIncomes()
        }
    }
}

struct IncomesView_Previews: PreviewProvider {
    static var previews: some View {
        IncomesView(viewModel: IncomesViewModel(incomesUseCase: IncomeUseCase(repository: RepositoryManager.shared)), viewFactory: ViewFactory(viewModelFactory: ViewModelFactory()))
    }
}
