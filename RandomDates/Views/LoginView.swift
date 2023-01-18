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
                VStack() {
                    if shouldShowLogo {
                        Image("Logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(.vertical, 100)
                    }
                    VStack(spacing: 30) {
                        TextField("Enter login", text: $login)
                            .padding(10)
                            .frame(minHeight: 55)
                            .background(Color.white)
                            .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .padding([.top,.horizontal], 35)
                            .font(.title3)
                            .shadow(radius: 6)
                        SecureField("Enter password", text: $password)
                            .padding(10)
                            .frame(minHeight: 55)
                            .background(Color.white)
                            .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .padding(.horizontal, 35)
                            .font(.title3)
                            .shadow(radius: 6)
                        Spacer()
                        Button(action: verifyLoginData) {
                            Text("Login")
                                .frame(minHeight: 55)
                                .frame(maxWidth: .infinity)
                                .background(ColorsApp.button)
                                .cornerRadius(12)
                                .padding([.bottom, .horizontal], 30)
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
        .alert(isPresented: $showVerifyErrorAlert,
               content: { Alert(title: Text("Please re-enter Login or Password"),
                                message: Text("Invalid Login/Password"))
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
