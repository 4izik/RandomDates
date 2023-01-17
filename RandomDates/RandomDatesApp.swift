//
//  RandomDatesApp.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 16.01.2023.
//

import SwiftUI

@main
struct RandomDatesApp: App {
    @State private var isUserAuth: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isUserAuth {
                MainView()
            } else {
                LoginView(isUserAuth: $isUserAuth)
            }
        }
    }
}
