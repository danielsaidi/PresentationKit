//
//  View+FullScreenCover.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    #if !os(macOS)
    /// Presents a cover when the presentation is active.
    func fullScreenCover<Item: Identifiable, Content: View>(
        for presentation: Binding<Presentation<Item>>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping (Item) -> Content
    ) -> some View {
        self.fullScreenCover(
            item: presentation.item,
            onDismiss: onDismiss,
            content: content
        )
    }
    #endif
}

#Preview {

    enum AppCover: String, Identifiable {

        case red, green, blue

        var id: String { rawValue }

        var content: some View {
            switch self {
            case .red: Color.red
            case .green: Color.green
            case .blue: Color.blue
            }
        }
    }

    struct MyView: View {

        @State var cover = Presentation<AppCover>()

        var body: some View {
            Button("Show Cover") {
                cover.present(.red)
            }
            #if !os(macOS)
            .fullScreenCover(for: $cover) { cover in
                cover.content
                    .ignoresSafeArea()
            }
            #endif
        }
    }

    return MyView()
}
