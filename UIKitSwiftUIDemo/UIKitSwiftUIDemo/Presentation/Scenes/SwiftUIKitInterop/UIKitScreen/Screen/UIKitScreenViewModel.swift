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
    
}

protocol UIKitScreenViewModelOutput {
    
}

typealias UIKitScreenViewModelProtocol = UIKitScreenViewModelInput & UIKitScreenViewModelOutput

final class UIKitScreenViewModel {
    weak var delegate: UIKitScreenViewModelDelegate?
}

extension UIKitScreenViewModel: UIKitScreenViewModelInput {
    
}

extension UIKitScreenViewModel: UIKitScreenViewModelOutput {
    
}
