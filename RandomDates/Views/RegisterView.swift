//
//  RegisterView.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 22.01.2023.
//

import SwiftUI
import Combine

struct RegisterView: View {
    //MARK: - User details
    
    @State private var email: String = ""
    @State private var password: String = ""
    //MARK: - View properties
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 10) {
            Text("Let's Registration\nAccount")
                .padding(.top, 20)
                .font(.largeTitle.bold())
            Text("Please, enter your information.")
                .foregroundColor(Color.gray)
                .font(.title3)
            VStack(spacing: 30) {
                TextField("Enter email", text: $email)
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
                Button("Register") {
                }
                .frame(minHeight: 55)
                .frame(maxWidth: .infinity)
                .background(ColorsApp.button2)
                .cornerRadius(12)
                .padding(.horizontal, 30)
                .font(.title3.bold())
                .foregroundColor(.white)
                .shadow(radius: 5)
                .disabled(email.isEmpty || password.isEmpty)
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
        }
    }
}
//MARK: - Preview

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
