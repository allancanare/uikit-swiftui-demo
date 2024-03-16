//
//  FrameworkSelectionViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/16.
//

import UIKit

protocol FrameworkSelectionViewModelDelegate: AnyObject {
    func frameworkSelectionViewModelWillClose(_ viewModel: any FrameworkSelectionViewModelProtocol)
    func frameworkSelectionViewModelWillShowUIKit(_ viewModel: any FrameworkSelectionViewModelProtocol)
    func frameworkSelectionViewModelWillShowSwiftUI(_ viewModel: any FrameworkSelectionViewModelProtocol)
}

protocol FrameworkSelectionViewModelProtocol: ObservableObject {
    func showUIKit()
    func showSwiftUI()
}

final class FrameworkSelectionViewModel {
    // MARK: Public Properties
    weak var delegate: FrameworkSelectionViewModelDelegate?
    
    // MARK: Private Properties
    private let navigationBarDataSource: NavigationBarDataSource
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
    }
}

// MARK: - FrameworkSelectionViewModelProtocol
extension FrameworkSelectionViewModel: FrameworkSelectionViewModelProtocol {
    func showUIKit() {
        delegate?.frameworkSelectionViewModelWillShowUIKit(self)
    }
    
    func showSwiftUI() {
        delegate?.frameworkSelectionViewModelWillShowSwiftUI(self)
    }
}

// MARK: - Private Functions
private extension FrameworkSelectionViewModel {
    func generateNavigationBarData() {
        navigationBarDataSource.setTitle("UIKit SwiftUI Interop")
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension FrameworkSelectionViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.frameworkSelectionViewModelWillClose(self)
    }
}
