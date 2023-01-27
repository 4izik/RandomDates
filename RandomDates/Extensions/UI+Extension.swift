//
//  SwiftUI+Extension.swift
//  RandomDates
//
//  Created by Andrey Piskunov on 17.01.2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
