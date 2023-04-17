//
//  LoginServiceKey.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import Foundation

class KeysService {
    enum Keys: String {
        case sessionID
    }

    static func get(_ key: KeysService.Keys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }

    static func set(_ value: Any?, for key: KeysService.Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
