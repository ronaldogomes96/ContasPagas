//
//  LocalizableStrings.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 11/04/23.
//

import Foundation
import SwiftUI

enum LocalizableStrings: String {
    
    // MARK: - LOGIN
    
    case appName = "login-appName"
    case loginMessageTitle = "login-messageTitle"
    case loginButtonTitle = "login-button-title"
    
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
}
