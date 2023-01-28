//
//  RegisterView.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 22.01.2023.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    //MARK: - View properties
    
    @StateObject private var loginModel = LoginModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Let's Registration\nAccount")
                .font(.largeTitle.bold())
            Text("Please, enter your information.")
                .foregroundColor(Color.gray)
                .font(.title3)
            VStack(spacing: 30) {
                TextField("Enter email", text: $loginModel.email)
                    .padding(10)
                    .frame(minHeight: 55)
                    .background(Color.white)
                    .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                    .cornerRadius(15)
                    .padding(.horizontal, 35)
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
                Button {
                    loginModel.registerUser()
                } label: {
                    Text("Registration")
                        .frame(minHeight: 55)
                        .frame(maxWidth: .infinity)
                        .background(ColorsApp.button2)
                        .cornerRadius(12)
                        .padding(.horizontal, 30)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .disabled(loginModel.email.isEmpty || loginModel.password.isEmpty)
                }
                HStack {
                    Text("Already have account?")
                        .foregroundColor(.gray)
                    Button("Login Now"){
                        dismiss()
                    }
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                }
                Spacer()
            }
            .alert(loginModel.errorMessage, isPresented: $loginModel.showError, actions: {})
        }
        .overlay(content: {
            LoadingAlertView(showLoading: $loginModel.isLoading)
        })
    }
}
//MARK: - Preview

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
