//
//  LoginViewController.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/23.
//

import UIKit
import Combine
import SwiftUI

final class UIKitScreenViewController: UIViewController {
    // MARK: Public Properties
    var viewModel: UIKitScreenViewModelProtocol!
    
    @IBOutlet private var label: UILabel!
    @IBOutlet private var viewWithViewModelContainer: UIView!
    @IBOutlet private var viewWithoutViewModelContainer: UIView!
    
    private lazy var viewWithoutViewModel = makeViewWithoutViewModel()
    private lazy var viewWithViewModel = makeViewWithViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(viewWithoutViewModel,
            toSubview: viewWithoutViewModelContainer)
        add(viewWithViewModel,
            toSubview: viewWithViewModelContainer)
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadData()
    }
}

private extension UIKitScreenViewController {
    func setupBindings() {
        viewModel.infoPublisher
            .sink { [weak self] info in
                self?.label.text = info
            }
            .store(in: &cancellables)
        
        viewModel.titlePublisher
            .sink { [weak self] title in
                self?.updateViewWithoutViewModel(withTitle: title)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - View Without ViewModel
    func makeViewWithoutViewModel() -> UIHostingController<SwiftUIWithoutViewModelView> {
        let view = SwiftUIWithoutViewModelView(title: "",
                                               tapHandler: viewWithoutViewModelTapHandler)
        let viewController = UIHostingController(rootView: view)
        viewController.sizingOptions = .intrinsicContentSize
        return viewController
    }
    
    func updateViewWithoutViewModel(withTitle title: String) {
        let view = SwiftUIWithoutViewModelView(title: title,
                                               tapHandler: viewWithoutViewModelTapHandler)
        viewWithoutViewModel.rootView = view
    }
    
    func viewWithoutViewModelTapHandler() {
        print("UIKitScreenViewController - View without ViewModel - Button Tapped")
    }
    
    // MARK: - View With ViewModel
    func makeViewWithViewModel() -> UIHostingController<SwiftUIWithViewModelView<SwiftUIWithViewModelViewModel>> {
        let view = SwiftUIWithViewModelView(viewModel: viewModel.viewWithViewModelViewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.sizingOptions = .intrinsicContentSize
        return viewController
    }
}
