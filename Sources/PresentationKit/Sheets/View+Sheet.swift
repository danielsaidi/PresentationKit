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

#Preview {

    enum AppSheet: String, Identifiable {
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

        @State var sheet = Presentation<AppSheet>()

        var body: some View {
            Button("Show Sheet") {
                sheet.present(.red)
            }
            .sheet(for: $sheet) { sheet in
                sheet.content
                    .ignoresSafeArea()
            }
        }
    }

    return MyView()
}
