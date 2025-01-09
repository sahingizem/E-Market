//
//  DefaultsService.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation
import Foundation

class UserDefaultsService { // a basic defaults service I used just for account controller name and surname textfields.
    
    private let userDefaults = UserDefaults.standard
    
    func saveString(_ value: String?, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func loadString(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    func saveBool(_ value: Bool, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func loadBool(forKey key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    func saveInteger(_ value: Int, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func loadInteger(forKey key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func clearAllData() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }
}
