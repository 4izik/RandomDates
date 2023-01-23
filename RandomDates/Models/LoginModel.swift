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
    @AppStorage("saved_email") var savedEmail: String = ""
    @AppStorage("saved_password") var savedPassword: String = ""
    
    func loginUser() async throws {
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        
        DispatchQueue.main.async { [self] in
            self.savedEmail = email
            self.savedPassword = password
            self.logStatus = true }
    }
    
    func registerUser() async throws {
        let _ = try await Auth.auth().createUser(withEmail: email, password: password)
        
        DispatchQueue.main.async { [self] in
            self.savedEmail = email
            self.savedPassword = password
            self.logStatus = true
        }
    }
}
