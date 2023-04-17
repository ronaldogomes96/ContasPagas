//
//  TradeView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import SwiftUI

struct TradeView: View {
    @ObservedObject var viewModel: TradeViewModel
    
    @State private var isPaied: Bool = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                
                VStack(spacing: 24) {
                    TextField("Tipo de finança", text: $viewModel.financeTypeName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Nome da finança", text: $viewModel.financeName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Valor da finança", text: $viewModel.tradeValue)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                    
                    DatePicker("Data: ",
                               selection: $viewModel.selectedDate,
                               displayedComponents: [.date])
                    
                    if viewModel.financeType == .expense {
                        Toggle("Pago", isOn: $isPaied)
                    }
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Ocorreu um erro"),
                          message: Text("Não foi possivel salvar os dados, tente novamente"),
                          dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarTitle("\(viewModel.tradeType.titleName) \(viewModel.financeType.rawValue)")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button("Salvar") {
                    if viewModel.saveTradeWithSuccess() {
                        
                    } else {
                        showAlert = true
                    }
                }
            }
        }
    }
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView(viewModel: TradeViewModel(tradeType: .edit, financeType: .expense))
    }
}
