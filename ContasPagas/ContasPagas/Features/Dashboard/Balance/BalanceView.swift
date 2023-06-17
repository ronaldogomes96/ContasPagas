//
//  BalanceView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 12/04/23.
//

import SwiftUI

struct BalanceView: View {
    @StateObject var viewModel: BalanceViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                
                VStack(spacing: 24) {
                    Text(LocalizableStrings.balanceYourBalance.localized)
                        .font(.title)
                    
                    Text("\($viewModel.totalBalance.wrappedValue)")
                        .font(.bold(.largeTitle)())
                        .foregroundColor(.green)
                    
                    List {
                        HStack {
                            Text(LocalizableStrings.balanceTotalEarnings.localized)
                            
                            Spacer()
                            
                            Text("\($viewModel.totalIncomes.wrappedValue)")
                                .foregroundColor(.green)
                        }
                        
                        HStack {
                            Text(LocalizableStrings.balanceTotalExpense.localized)
                            
                            Spacer()
                            
                            Text("\($viewModel.totalExpenses.wrappedValue)")
                                .foregroundColor(.red)
                        }
                    }
                    .listStyle(.grouped)
                }
                
                .padding(.top, 32)
            }
            .navigationTitle(LocalizableStrings.tabbarBalance.localized)
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.getUserInformations()
            }
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
//        BalanceView(viewModel: BalanceViewModel(incomeUseCase: <#T##any FinancesUseCaseProtocol#>, expenseTypeUseCase: <#T##any FinancesUseCaseProtocol#>, expensesUseCase: <#T##any FinancesUseCaseProtocol#>))
    }
}
