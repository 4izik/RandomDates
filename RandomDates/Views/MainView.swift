//
//  MainView.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 17.01.2023.
//

import SwiftUI

struct MainView: View {
    //MARK: - View properties
    
    @StateObject private var loginModel = LoginModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
            }
            .navigationTitle("MainView")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Login Out",
                               action: loginModel.logOutUser)
                        Button("Delete Account",
                               role: .destructive,
                               action: loginModel.deleteUser)
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                            .tint(.black)
                    }
                }
            }
        }
        .overlay(content: {
            LoadingAlertView(showLoading: $loginModel.isLoading)
        })
    }
}
//MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
