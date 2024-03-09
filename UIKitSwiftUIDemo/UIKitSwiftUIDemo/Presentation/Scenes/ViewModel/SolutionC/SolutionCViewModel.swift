//
//  SolutionCViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import Foundation
import Combine

protocol SolutionCViewModelProtocol: ObservableObject {
    var name: String { get set }
    var isActionEnabled: Bool { get }
}

final class SolutionCViewModel {
    @Published var name = "" {
        didSet {
            print("ViewModel - name: \(name)")
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

extension SolutionCViewModel: SolutionCViewModelProtocol { }
