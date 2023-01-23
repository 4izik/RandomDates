//
//  RandomDatesApp.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 16.01.2023.
//

import SwiftUI
import Firebase

@main
struct RandomDatesApp: App {
    @AppStorage("log_status") var logStatus: Bool = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if logStatus {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}
