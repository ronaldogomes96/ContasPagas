//
//  BalanceView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 12/04/23.
//

import SwiftUI

struct BalanceView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                
                VStack(spacing: 24) {
                    Text(LocalizableStrings.balanceYourBalance.localized)
                        .font(.title)
                    
                    Text("R$ 50,00")
                        .font(.bold(.largeTitle)())
                        .foregroundColor(.green)
                    
                    List {
                        HStack {
                            Text(LocalizableStrings.balanceTotalEarnings.localized)
                            
                            Spacer()
                            
                            Text("R$ 100")
                                .foregroundColor(.green)
                        }
                        
                        HStack {
                            Text(LocalizableStrings.balanceTotalExpense.localized)
                            
                            Spacer()
                            
                            Text("R$ 50")
                                .foregroundColor(.red)
                        }
                    }
                    .listStyle(.grouped)
                }
                
                .padding(.top, 32)
            }
            .navigationTitle(LocalizableStrings.tabbarBalance.localized)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
