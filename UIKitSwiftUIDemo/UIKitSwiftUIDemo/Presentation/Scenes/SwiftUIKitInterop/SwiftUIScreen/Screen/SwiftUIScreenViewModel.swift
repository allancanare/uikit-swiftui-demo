//
//  SwiftUIScreenViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/24.
//

import Foundation
import Combine

final class SwiftUIScreenViewModel: ObservableObject {
    @Published var title = "UIKit UILabel"
    
    init() {
        updateProperties()
    }
    
    func updateProperties() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.title = "UIKit UILabel - Without ViewModel"
        }
    }
}
