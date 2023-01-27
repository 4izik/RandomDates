//
//  ContentView.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 16.01.2023.
//

import SwiftUI
import Combine
import Firebase

struct LoginView: View {
    //MARK: - View properties
    @StateObject private var loginModel = LoginModel()
    @State private var createAccount: Bool = false
    @State private var shouldShowLogo: Bool = true
    
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
                            .padding(.vertical, 50)
                    }
                    VStack(spacing: 20) {
                        TextField("Enter email", text: $loginModel.email)
                            .padding(10)
                            .frame(minHeight: 55)
                            .background(Color.white)
                            .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .padding([.top,.horizontal], 35)
                            .font(.title3)
                            .shadow(radius: 6)
                        SecureField("Enter password", text: $loginModel.password)
                            .padding(10)
                            .frame(minHeight: 55)
                            .background(Color.white)
                            .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .padding(.horizontal, 35)
                            .font(.title3)
                            .shadow(radius: 6)
                        Spacer()
                        Button {
                            Task {
                                do {
                                    try await loginModel.loginUser()
                                } catch {
                                    loginModel.errorMessage = error.localizedDescription
                                    loginModel.showError.toggle()
                                }
                            }
                        } label: {
                            Text("Login")
                                .frame(minHeight: 55)
                                .frame(maxWidth: .infinity)
                                .background(ColorsApp.button1)
                                .cornerRadius(12)
                                .padding(.horizontal, 30)
                                .font(.title3.bold())
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .disabled(loginModel.email.isEmpty || loginModel.password.isEmpty)
                        }
                        Text ("Don't have account?")
                            .foregroundColor(.gray)
                        Button("Register now") {
                            createAccount.toggle()
                        }
                        .frame(minHeight: 45)
                        .frame(maxWidth: .infinity)
                        .background(ColorsApp.button2)
                        .cornerRadius(12)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 100)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .opacity(0.85)
                    }
                    .alert(loginModel.errorMessage, isPresented: $loginModel.showError, actions: {})
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
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(ColorsApp.background)
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
    }
}
//MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
