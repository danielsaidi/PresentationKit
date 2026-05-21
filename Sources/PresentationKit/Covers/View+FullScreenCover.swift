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
