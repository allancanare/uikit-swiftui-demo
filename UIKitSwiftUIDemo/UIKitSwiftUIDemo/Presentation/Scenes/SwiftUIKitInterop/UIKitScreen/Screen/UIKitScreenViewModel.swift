//
//  LoginViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/23.
//

import Foundation

// MARK: - Protocols
protocol UIKitScreenViewModelDelegate: AnyObject {
    
}

protocol UIKitScreenViewModelInput {
    func loadData()
}

protocol UIKitScreenViewModelOutput {
    var infoPublisher: Published<String>.Publisher { get }
    var titlePublisher: Published<String>.Publisher { get }
    var viewWithViewModelViewModel: SwiftUIWithViewModelViewModel { get }
}

typealias UIKitScreenViewModelProtocol = UIKitScreenViewModelInput & UIKitScreenViewModelOutput

final class UIKitScreenViewModel {
    weak var delegate: UIKitScreenViewModelDelegate?
    
    @Published private var infoPublished = "UIKit UILabel"
    @Published private var titlePublished = "SwiftUI Text"
    
    private lazy var swiftUIWithViewModelViewModel = {
        let viewModel = SwiftUIWithViewModelViewModel()
        viewModel.delegate = self
        return viewModel
    }()
}

extension UIKitScreenViewModel: UIKitScreenViewModelInput {
    func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.infoPublished = "UIKit UILabel - Updated"
            self.titlePublished = "SwiftUI Text - Without ViewModel"
        }
    }
}

extension UIKitScreenViewModel: UIKitScreenViewModelOutput {
    var infoPublisher: Published<String>.Publisher {
        return $infoPublished
    }
    
    var titlePublisher: Published<String>.Publisher {
        return $titlePublished
    }
    
    var viewWithViewModelViewModel: SwiftUIWithViewModelViewModel {
        return swiftUIWithViewModelViewModel
    }
}

extension UIKitScreenViewModel: SwiftUIWithViewModelViewModelDelegate {
    func swiftUIWithViewModelViewModelDidTapButton() {
        print("UIKitScreenViewModel - View with ViewModel - Button Tapped")
    }
}
