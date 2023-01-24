//
//  KeyChainWrapper.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 24.01.2023.
//

import SwiftUI

@propertyWrapper
struct KeyChain: DynamicProperty {
    
    @State var data: Data?
    
    var wrappedValue: Data? {
        get {
            data
        }
        set {
            guard let newData = newValue else {
                data = nil
                KeyChainHelper.standart.delete(key: key, account: account)
                return
            }
            KeyChainHelper.standart.save(data: newData, key: key, account: account)
        }
    }
    
    var key: String
    var account: String
    
    init(key: String, account: String) {
        self.key = key
        self.account = account
        
        _data = State(wrappedValue: KeyChainHelper.standart.read(key: key, account: account))
    }
}
