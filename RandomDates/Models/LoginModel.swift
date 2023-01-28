//
//  LoginModel.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 23.01.2023.
//

import SwiftUI
import Firebase

class LoginModel: ObservableObject {
    //MARK: - Properties

    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isLoading: Bool = false
    
    @AppStorage("log_status") var logStatus: Bool = false
    @KeyChain(key: "use_email", account: "Login") var storedEmail
    @KeyChain(key: "use_password", account: "Login") var storedPassword
    
    //MARK: - Functions
    
    func loginUser(){
        isLoading = true
        Task {
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                
                DispatchQueue.main.async { [self] in
                    let emailData = self.email.data(using: .utf8)
                    let passwordData = self.password.data(using: .utf8)
                    self.storedEmail = emailData
                    self.storedPassword = passwordData
                    self.logStatus = true
                }
            } catch {
                await setError(error)
            }
        }
    }
    
    func registerUser() {
        isLoading = true
        Task {
            do {
                try await Auth.auth().createUser(withEmail: email, password: password)
                
                DispatchQueue.main.async { [self] in
                    let emailData = self.email.data(using: .utf8)
                    let passwordData = self.password.data(using: .utf8)
                    self.storedEmail = emailData
                    self.storedPassword = passwordData
                    self.logStatus = true
                }
            } catch {
                await setError(error)
            }
        }
    }
    
    func logOutUser() {
        try? Auth.auth().signOut()
        logStatus = false
    }
    
    func deleteUser() {
        isLoading = true
        Task {
            do {
                try await Auth.auth().currentUser?.delete()
                DispatchQueue.main.async { [self] in
                    self.logStatus = false
                }
            } catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            isLoading = false
            showError.toggle()
            errorMessage = error.localizedDescription
        })
    }
}
