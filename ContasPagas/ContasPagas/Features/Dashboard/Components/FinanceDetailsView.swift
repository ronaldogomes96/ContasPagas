//
//  DetailsView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 13/04/23.
//

import SwiftUI

struct FinanceDetailsView: View {
    private let name: String
    private let date: Date
    private let value: Double
    private let paid: Bool?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    init(name: String, date: Date, value: Double, paid: Bool?) {
        self.name = name
        self.date = date
        self.value = value
        self.paid = paid
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.bold(.title3)())
                
                Text("\(LocalizableStrings.tradeFinanceDate.localizedString) \(date, formatter: dateFormatter)")
                
                if let paid {
                    Text("\(LocalizableStrings.financeDetailsSituationLabel.localizedString) \(paid ? LocalizableStrings.tradeToglePayed.localizedString : LocalizableStrings.financeDetailsNotPaid.localizedString)")
                        .foregroundColor(paid ? .green : .red)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("RS \(String(format: "%.2f", value))")
                .font(.bold(.body)())
                .foregroundColor(paid ?? true ? .green : .red)
        }
    }
}

struct FinanceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceDetailsView(name: "Uber",
                           date: Date(),
                           value: 27.60,
                           paid: false)
    }
}
