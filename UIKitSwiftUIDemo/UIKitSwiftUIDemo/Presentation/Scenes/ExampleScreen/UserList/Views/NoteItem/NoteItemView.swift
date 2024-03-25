//
//  NoteItemView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/25.
//

import SwiftUI
import AtomicDS

struct NoteItemView<ViewModel: NoteItemViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ExpandableView {
            TextView(viewModel.title,
                     style: .bodyMediumDarkGrayDarkest)
        } content: {
            TextView(viewModel.content,
                     style: .bodySmallDarkGrayLight)
        }
    }
}

#Preview {
    NavigationView {
        List {
            NoteItemView(viewModel: NoteItemViewModel(noteModel: .init(id: UUID().uuidString,
                                                                       title: "Title 1",
                                                                       content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tempor id eu nisl nunc mi ipsum faucibus vitae aliquet.")))
        }
    }
}
