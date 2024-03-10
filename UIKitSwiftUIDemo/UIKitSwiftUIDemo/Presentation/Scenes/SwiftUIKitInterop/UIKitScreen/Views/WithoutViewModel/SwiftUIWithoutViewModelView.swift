//
//  SwiftUIWithoutViewModelView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/10.
//

import SwiftUI

struct SwiftUIWithoutViewModelView: View {
    let title: String
    let tapHandler: () -> Void
    
    @State private var tapCount = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .lineLimit(nil)
            Button {
                tapCount += 1
                tapHandler()
            } label: {
                Text("Tap Me")
                    .font(.headline)
            }
            Text("Button Tap Counter: \(tapCount)")
                .font(.caption)
        }
    }
}

#Preview {
    SwiftUIWithoutViewModelView(title: "Product name") {
        print("Tapped")
    }
}
