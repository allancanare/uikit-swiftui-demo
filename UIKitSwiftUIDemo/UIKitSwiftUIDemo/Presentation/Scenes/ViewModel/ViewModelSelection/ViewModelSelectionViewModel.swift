//
//  ViewModelSelectionViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/16.
//

import UIKit

protocol ViewModelSelectionViewModelDelegate: AnyObject {
    func viewModelSelectionViewModelWillClose(_ viewModel: any ViewModelSelectionViewModelProtocol)
    func viewModelSelectionViewModelWillShowSolutionA(_ viewModel: any ViewModelSelectionViewModelProtocol)
    func viewModelSelectionViewModelWillShowSolutionB(_ viewModel: any ViewModelSelectionViewModelProtocol)
    func viewModelSelectionViewModelWillShowSolutionC(_ viewModel: any ViewModelSelectionViewModelProtocol)
}

protocol ViewModelSelectionViewModelProtocol: ObservableObject {
    func showSolutionA()
    func showSolutionB()
    func showSolutionC()
}

final class ViewModelSelectionViewModel {
    // MARK: Public Properties
    weak var delegate: ViewModelSelectionViewModelDelegate?
    
    // MARK: Private Properties
    private let navigationBarDataSource: NavigationBarDataSource
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
    }
}

// MARK: - ViewModelSelectionViewModelProtocol
extension ViewModelSelectionViewModel: ViewModelSelectionViewModelProtocol {
    func showSolutionA() {
        delegate?.viewModelSelectionViewModelWillShowSolutionA(self)
    }
    
    func showSolutionB() {
        delegate?.viewModelSelectionViewModelWillShowSolutionB(self)
    }
    
    func showSolutionC() {
        delegate?.viewModelSelectionViewModelWillShowSolutionC(self)
    }
}

// MARK: - Private Functions
private extension ViewModelSelectionViewModel {
    func generateNavigationBarData() {
        navigationBarDataSource.setTitle("View Model")
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension ViewModelSelectionViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.viewModelSelectionViewModelWillClose(self)
    }
}
