//
//  ExpandableView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/24.
//

import SwiftUI
import AtomicDS

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
        VStack(alignment: .leading,
               spacing: 0) {
            headerView
            if isContentVisible {
                contentView
            }
        }
        .cornerRadius(.init(borderRadius: .medium))
        .overlay {
            RoundedRectangle(cornerRadius: .init(borderRadius: .medium))
                .stroke(AtomicDS.Color.lightGrayDarkest.value,
                        lineWidth: .init(borderWidth: .small))
        }
        .animation(.default, value: isContentVisible)
    }
    
    var headerView: some View {
        HStack {
            header
            Spacer()
            arrow
                .padding(.leading, .init(spacing: .small))
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            isContentVisible.toggle()
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        Divider()
        content
            .padding()
    }
    
    var arrow: some View {
        IconView(isContentVisible ? .arrowUp : .arrowDown,
                 color: .darkGrayLightest,
                 style: .small)
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
