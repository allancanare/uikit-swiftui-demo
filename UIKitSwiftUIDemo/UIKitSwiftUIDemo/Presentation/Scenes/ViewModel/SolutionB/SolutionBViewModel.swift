//
//  SolutionBViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import Foundation
import Combine

final class SolutionBViewModel: ObservableObject {
    @Published var name = "" {
        didSet {
            print("SolutionBViewModel - name: \(name)")
        }
    }
    @Published var isActionEnabled = false
    
    init() {
        updateProperties()
    }
    
    func updateProperties() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.name = "name updated"
            self.isActionEnabled = true
        }
    }
}
