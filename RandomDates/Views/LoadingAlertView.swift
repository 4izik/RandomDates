//
//  LoadingAlertView.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 26.01.2023.
//

import SwiftUI

struct LoadingAlertView: View {
    
    @Binding var showLoading: Bool
    
    var body: some View {
        ZStack {
            if showLoading {
                Group{
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    ProgressView()
                        .padding(15)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showLoading)
    }
}
