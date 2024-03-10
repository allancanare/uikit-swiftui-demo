//
//  SwiftUIWithViewModelViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/10.
//

import Foundation
import Combine

protocol SwiftUIWithViewModelViewModelDelegate: AnyObject {
    func swiftUIWithViewModelViewModelDidTapButton()
}

protocol SwiftUIWithViewModelViewModelProtocol: ObservableObject {
    var title: String { get }
    var tapCount: Int { get }
    func didTapButton()
}

final class SwiftUIWithViewModelViewModel {
    weak var delegate: SwiftUIWithViewModelViewModelDelegate?
    @Published var title = "SwiftUI Text"
    @Published var tapCount = 0
    
    init() {
        updateProperties()
    }
    
    func updateProperties() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.title = "SwiftUI Text - With ViewModel"
        }
    }
}

extension SwiftUIWithViewModelViewModel: SwiftUIWithViewModelViewModelProtocol {
    func didTapButton() {
        tapCount += 1
        delegate?.swiftUIWithViewModelViewModelDidTapButton()
        print("SwiftUIWithViewModelViewModel - viewWithViewModelTapHandler")
    }
}
