//
//  ExpandableView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/24.
//

import SwiftUI

struct ExpandableView<HeaderView: View, ContentView: View>: View {
    var header: HeaderView
    var content: ContentView
    
    @State private var isContentVisible = false
    
    init(@ViewBuilder header: () -> HeaderView,
         @ViewBuilder content: () -> ContentView) {
        self.header = header()
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                header
                Spacer()
                arrow
                    .padding(.leading, 8)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isContentVisible.toggle()
            }
            .padding()

            if isContentVisible {
                Divider()
                content
                    .padding()
            }
        }
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray,
                        lineWidth: 1)
        }
        .animation(.default, value: isContentVisible)
    }
    
    @ViewBuilder
    var arrow: some View {
        Image(systemName: isContentVisible ? "chevron.up" : "chevron.down")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 12, height: 12)
            .contentTransition(.symbolEffect(.replace))
    }
}

#Preview {
    NavigationView {
        List {
            ExpandableView {
                HStack(alignment: .center) {
                    Text("This is the header")
                    Spacer()
                    Text("2024/03/24")
                        .font(.caption2)
                }
            } content: {
                Text("The quick brown fox jumps over the lazy dog near the river bank.")
            }
            .listRowSeparator(.hidden)
            
            ExpandableView {
                Text("This is the header")
            } content: {
                Text("The quick brown fox jumps over the lazy dog near the river bank.")
            }
            .listRowSeparator(.hidden)
            
            ExpandableView {
                Text("This is the header")
            } content: {
                Text("The quick brown fox jumps over the lazy dog near the river bank.")
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("ExpandableView")
    }
}
