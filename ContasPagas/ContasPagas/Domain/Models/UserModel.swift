//
//  UserModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 03/06/23.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var name: String
    var email: String
    var expenseModel: ExpensesModel
    var incomes: [IncomeDetailsModel]
}

extension UserModel {
    static let collectionName = "contasPagasUserModel"
}
