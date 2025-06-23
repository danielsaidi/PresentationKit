//
//  DemoPreview.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view is used to inject demo preview logic into each
/// preview used in the demo.
struct DemoPreview<Content: View>: View {

    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    var content: () -> Content

    var body: some View {
        content()
            .withDemoPresentation()
    }
}
