//
//  AnyUserItemViewModelProtocol.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/21.
//

import Foundation

struct AnyUserItemViewModelProtocol<ViewModel> where ViewModel: UserItemViewModelProtocol {
    let viewModel: ViewModel
}
