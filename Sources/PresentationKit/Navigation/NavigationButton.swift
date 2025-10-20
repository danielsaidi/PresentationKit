//
//  ListNavigationButton.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-20.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view renders a `Button` that mimics a native `NavigatonLink`.
public struct NavigationButton<Content: View>: View {
    
    public init(
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.action = action
        self.content = content
    }
    
    private let action: () -> Void
    private let content: () -> Content
    
    public var body: some View {
        Button(action: action) {
            HStack {
                content()
                Spacer()
                NavigationChevron()
            }
        }
    }
}

#if os(iOS)
#Preview {
    
    struct Preview: View {
        
        @State
        var isToggled = false
        
        var body: some View {
            NavigationView {
                List {
                    NavigationLink {
                        Text("Destination")
                    } label: {
                        Text("Link")
                    }
                    .offset()
                    
                    NavigationButton(action: { isToggled.toggle() }, content: {
                        Text("Button")
                    })
                }
            }.foregroundColor(.red)
        }
    }
    
    return Preview()
}
#endif
