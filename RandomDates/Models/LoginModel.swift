//
//  LoginModel.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 23.01.2023.
//

import SwiftUI
import Firebase

class LoginModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @AppStorage("log_status") var logStatus: Bool = false
    
    @KeyChain(key: "use_email", account: "Login") var storedEmail
    @KeyChain(key: "use_password", account: "Login") var storedPassword
    
    func loginUser() async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        
        DispatchQueue.main.async { [self] in
            let emailData = self.email.data(using: .utf8)
            let passwordData = self.password.data(using: .utf8)
            self.storedEmail = emailData
            self.storedPassword = passwordData
            self.logStatus = true
        }
    }
    
    func registerUser() async throws {
        
        let _ = try await Auth.auth().createUser(withEmail: email, password: password)
        
        DispatchQueue.main.async { [self] in
            let emailData = self.email.data(using: .utf8)
            let passwordData = self.password.data(using: .utf8)
            self.storedEmail = emailData
            self.storedPassword = passwordData
            self.logStatus = true
        }
    }
}
