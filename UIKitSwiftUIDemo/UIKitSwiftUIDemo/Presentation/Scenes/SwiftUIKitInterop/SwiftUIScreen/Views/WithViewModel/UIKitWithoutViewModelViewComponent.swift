//
//  UIKitWithoutViewModelViewComponent.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/10.
//

import Foundation
import SwiftUI

struct UIKitWithoutViewModelViewComponent: UIViewRepresentable {
    var title: String
    var buttonTapHandler: () -> Void
    
    func makeUIView(context: Context) -> UIKitWithoutViewModelView {
        let view = UIKitWithoutViewModelView()
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ view: UIKitWithoutViewModelView, context: Context) {
        view.setTitle(title)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: UIKitWithoutViewModelViewDelegate {
        let parent: UIKitWithoutViewModelViewComponent
        
        init(_ parent: UIKitWithoutViewModelViewComponent) {
            self.parent = parent
        }
        
        func uiKitWithoutViewModelViewDidTapButton() {
            parent.buttonTapHandler()
        }
    }
}
