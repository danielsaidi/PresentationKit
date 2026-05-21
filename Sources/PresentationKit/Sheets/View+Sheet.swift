//
//  View+FullScreenCover.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Presents a sheet when the presentation is active.
    func sheet<Item: Identifiable, Content: View>(
        for presentation: Binding<Presentation<Item>>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping (Item) -> Content
    ) -> some View {
        self.sheet(
            item: presentation.item,
            onDismiss: onDismiss,
            content: content
        )
    }
}
