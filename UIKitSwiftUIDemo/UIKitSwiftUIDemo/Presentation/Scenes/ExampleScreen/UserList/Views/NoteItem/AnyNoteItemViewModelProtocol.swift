//
//  AnyNoteItemViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/25.
//

import Foundation

struct AnyNoteItemViewModelProtocol<ViewModel> where ViewModel: NoteItemViewModelProtocol {
    let viewModel: ViewModel
}
