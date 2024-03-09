//
//  FrameworkSelectionView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

protocol FrameworkSelectionViewDelegate {
    func frameworkSelectionViewWillShowUIKit()
    func frameworkSelectionViewWillShowSwiftUI()
}

struct FrameworkSelectionView: View {
    var delegate: FrameworkSelectionViewDelegate?
    var body: some View {
        List {
            Button {
                delegate?.frameworkSelectionViewWillShowUIKit()
            } label: {
                Text("UIKit")
            }
            Button {
                delegate?.frameworkSelectionViewWillShowSwiftUI()
            } label: {
                Text("SwiftUI")
            }
        }
    }
}

#Preview {
    FrameworkSelectionView()
}
