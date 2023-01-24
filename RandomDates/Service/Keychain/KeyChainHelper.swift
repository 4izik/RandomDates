//
//  Keychain.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 24.01.2023.
//

import SwiftUI

class KeyChainHelper {
    
    static let standart = KeyChainHelper()
    
    //MARK: - Save KeyChain Data
    func save(data: Data, key: String, account: String) {
        
        //Create query
        let query = [
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        //Add Data to KeyChain
        let status = SecItemAdd(query, nil)
        
        switch status {
        case errSecSuccess: print("Success")
        case errSecDuplicateItem:
            let updateQuery = [
                kSecAttrAccount: account,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            //Update field
            let updateAttr = [kSecValueData: data] as CFDictionary
            SecItemUpdate(updateQuery, updateAttr)
            
        default: print("Error \(status)")
        }
    }
    //MARK: - Read KeyChain Data
    
    func read(key: String, account: String) -> Data? {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        //Copy Data
        var resultData: AnyObject?
        SecItemCopyMatching(query, &resultData)
        
        return (resultData as? Data)
    }
    //MARK: - Delete KeyChain Data
    
    func delete(key: String, account: String){
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
