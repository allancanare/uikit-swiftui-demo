//
//  SolutionAViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import Foundation

protocol SolutionAViewModelInput: ObservableObject {
    func setName(_ name: String)
}

protocol SolutionAViewModelOutput: ObservableObject {
    var isActionEnabledPublisher: Published<Bool>.Publisher { get }
    var namePublisher: Published<String>.Publisher { get }
}

typealias SolutionAViewModelProtocol = SolutionAViewModelInput & SolutionAViewModelOutput

final class SolutionAViewModel: ObservableObject {
    @Published private var isActionEnabled = false
    @Published private var name = "" {
        didSet {
            print("ViewModel - name: \(name)")
        }
    }
    
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

extension SolutionAViewModel: SolutionAViewModelInput {
    func setName(_ name: String) {
        guard self.name != name else { return }
        self.name = name
    }
}

extension SolutionAViewModel: SolutionAViewModelOutput {
    var isActionEnabledPublisher: Published<Bool>.Publisher {
        return $isActionEnabled
    }
    
    var namePublisher: Published<String>.Publisher {
        return $name
    }
}
