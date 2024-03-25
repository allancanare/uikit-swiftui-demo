//
//  NoteItemViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/25.
//

import Foundation
import Combine

protocol NoteItemViewModelProtocol: ObservableObject {
    var id: NoteID { get }
    var title: String { get }
    var content: String { get }
}

final class NoteItemViewModel {
    @Published var title = ""
    @Published var content = ""
    
    @Published private var noteModel: NoteModel
    private var cancellables = Set<AnyCancellable>()
    
    init(noteModel: NoteModel) {
        self.noteModel = noteModel
        setupBindings()
    }
}

// MARK: - NoteItemViewModelProtocol
extension NoteItemViewModel: NoteItemViewModelProtocol {
    var id: NoteID {
        return noteModel.id
    }
}

// MARK: - Private Functions
private extension NoteItemViewModel { }

// MARK: - Private Functions
private extension NoteItemViewModel {
    func setupBindings() {
        $noteModel
            .sink { [weak self] noteModel in
                self?.title = noteModel.title
                self?.content = noteModel.content
            }
            .store(in: &cancellables)
    }
}
