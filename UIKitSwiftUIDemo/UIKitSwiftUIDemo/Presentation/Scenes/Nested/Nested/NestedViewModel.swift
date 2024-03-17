//
//  NestedViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/17.
//

import UIKit

protocol NestedViewModelDelegate: AnyObject {
    func nestedViewModelWillClose(_ viewModel: any NestedViewModelProtocol)
    func nestedViewModelWillShowPushedScreen(_ viewModel: any NestedViewModelProtocol)
    func nestedViewModelWillShowPresentedScreen(_ viewModel: any NestedViewModelProtocol)
}

protocol NestedViewModelProtocol: ObservableObject {
    func showPushedScreen()
    func showPresentedScreen()
}

final class NestedViewModel {
    // MARK: Public Properties
    weak var delegate: NestedViewModelDelegate?
    
    // MARK: Private Properties
    private let navigationBarDataSource: NavigationBarDataSource
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
    }
}

// MARK: - NestedViewModelProtocol
extension NestedViewModel: NestedViewModelProtocol {
    func showPushedScreen() {
        delegate?.nestedViewModelWillShowPushedScreen(self)
    }
    
    func showPresentedScreen() {
        delegate?.nestedViewModelWillShowPresentedScreen(self)
    }
}

// MARK: - Private Functions
private extension NestedViewModel {
    func generateNavigationBarData() {
        navigationBarDataSource.setTitle("Nested")
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension NestedViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.nestedViewModelWillClose(self)
    }
}
