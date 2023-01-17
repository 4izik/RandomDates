//
//  ContentView.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 16.01.2023.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var shouldShowLogo: Bool = true
    @State private var showVerifyErrorAlert = false
    
    @Binding var isUserAuth: Bool
    
    private func verifyLoginData() {
        if login == "login" && password == "password" {
            isUserAuth = true
        } else {
            showVerifyErrorAlert = true
        }
        password = ""
    }
    
    private let keyboardIsOnPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map { _ in true },
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }
    ).removeDuplicates()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 100) {
                    if shouldShowLogo {
                        Image("Logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(.top, 100)
                    }
                    VStack {
                        TextField("Enter login", text: $login)
                            .padding()
                            .background(Color.white)
                            .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .padding(8)
                            .padding(.top, 40)
                            .padding(.horizontal, 30)
                            .font(.title3)
                            .shadow(radius: 6)
                        SecureField("Enter password", text: $password)
                            .padding()
                            .background(Color.white)
                            .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .padding(8)
                            .padding(.horizontal, 30)
                            .font(.title3)
                            .shadow(radius: 6)
                        Spacer()
                            .frame(height: 40)
                        Button(action: verifyLoginData) {
                            Text("Login")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(ColorsApp.button)
                                .cornerRadius(12)
                                .padding(8)
                                .padding(.bottom, 40)
                                .padding(.horizontal, 30)
                                .font(.title3.bold())
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        .disabled(login.isEmpty || password.isEmpty)
                    }
                    .background(Color(.white))
                    .cornerRadius(30)
                    .padding(15)
                    .shadow(radius: 3)
                }
            }
            .onReceive(keyboardIsOnPublisher) { iskeyboardOn in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    shouldShowLogo = !iskeyboardOn }
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .alert(isPresented: $showVerifyErrorAlert,
               content: { Alert(title: Text("Error"),
                                message: Text("Incorrent Login/Password was entered"))
        })
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(ColorsApp.background)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isUserAuth: (.constant(false)))
    }
}
