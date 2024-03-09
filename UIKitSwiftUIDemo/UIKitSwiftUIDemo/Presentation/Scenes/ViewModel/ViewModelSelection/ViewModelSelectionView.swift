//
//  ViewModelSelectionView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

protocol ViewModelSelectionViewDelegate {
    func viewModelSelectionViewWillShowSolutionA()
    func viewModelSelectionViewWillShowSolutionB()
    func viewModelSelectionViewWillShowSolutionC()
}

struct ViewModelSelectionView: View {
    var delegate: ViewModelSelectionViewDelegate?
    var body: some View {
        List {
            Button {
                delegate?.viewModelSelectionViewWillShowSolutionA()
            } label: {
                Text("Solution A")
            }
            Button {
                delegate?.viewModelSelectionViewWillShowSolutionB()
            } label: {
                Text("Solution B")
            }
            Button {
                delegate?.viewModelSelectionViewWillShowSolutionC()
            } label: {
                Text("Solution C")
            }
        }
    }
}

#Preview {
    ViewModelSelectionView()
}
