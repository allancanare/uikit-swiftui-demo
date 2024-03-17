//
//  HomeSelectionViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/16.
//

import UIKit

protocol HomeSelectionViewModelDelegate: AnyObject {
    func homeSelectionViewModelWillClose(_ viewModel: any HomeSelectionViewModelProtocol)
    func homeSelectionViewModelWillShowViewModel(_ viewModel: any HomeSelectionViewModelProtocol)
    func homeSelectionViewModelWillShowSwiftUIKitInterop(_ viewModel: any HomeSelectionViewModelProtocol)
    func homeSelectionViewModelWillShowExampleScreen(_ viewModel: any HomeSelectionViewModelProtocol)
    func homeSelectionViewModelWillShowNestedCoordinators(_ viewModel: any HomeSelectionViewModelProtocol)
}

protocol HomeSelectionViewModelProtocol: ObservableObject {
    func showViewModel()
    func showSwiftUIKitInterop()
    func showExampleScreen()
    func showNestedCoordinators()
}

final class HomeSelectionViewModel {
    // MARK: Public Properties
    weak var delegate: HomeSelectionViewModelDelegate?
    
    // MARK: Private Properties
    private let navigationBarDataSource: NavigationBarDataSource
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
    }
}

// MARK: - HomeSelectionViewModelProtocol
extension HomeSelectionViewModel: HomeSelectionViewModelProtocol {
    func showViewModel() {
        delegate?.homeSelectionViewModelWillShowViewModel(self)
    }
    
    func showSwiftUIKitInterop() {
        delegate?.homeSelectionViewModelWillShowSwiftUIKitInterop(self)
    }
    
    func showExampleScreen() {
        delegate?.homeSelectionViewModelWillShowExampleScreen(self)
    }
    
    func showNestedCoordinators() {
        delegate?.homeSelectionViewModelWillShowNestedCoordinators(self)
    }
}

// MARK: - Private Functions
private extension HomeSelectionViewModel {
    func generateNavigationBarData() {
        navigationBarDataSource.setTitle("Home")
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension HomeSelectionViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.homeSelectionViewModelWillClose(self)
    }
}
