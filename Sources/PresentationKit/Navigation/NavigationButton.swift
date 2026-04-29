//
//  ListNavigationButton.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-20.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This `Button` mimics a native `NavigatonLink`. It can be
/// used to trigger a function in combination with a push.
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
            }
            .navigationChevronStyle(.init(font: .body.weight(.black), color: .red))
        }
    }
    
    return Preview()
}
#endif
