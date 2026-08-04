//
//  View+Popover.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-08-04.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public extension View {

    /// Presents a popover when the presentation is active.
    ///
    /// The modifier will automatically apply a presentation
    /// popover adaptation to the content view, so you don't
    /// have to.
    func popover<Item: Identifiable, Content: View>(
        for presentation: Binding<Presentation<Item>>,
        attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
        arrowEdge: Edge? = nil,
        content: @escaping (Item) -> Content
    ) -> some View {
        self.popover(
            item: presentation.item,
            attachmentAnchor: attachmentAnchor,
            arrowEdge: arrowEdge,
            content: { item in
                content(item).presentationCompactAdaptation(.popover)
            }
        )
    }
}

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
#Preview {

    enum AppPopover: String, Identifiable {
        case red, green, blue

        var id: String { rawValue }

        var color: Color {
            switch self {
            case .red: .red
            case .green: .green
            case .blue: .blue
            }
        }

        var content: some View {
            color
                .cornerRadius(20)
                .padding()
                .frame(idealWidth: 320, idealHeight: 240)
        }
    }

    struct MyView: View {

        @State var popover = Presentation<AppPopover>()

        var body: some View {
            Button("Show Popover") {
                popover.present(.red)
            }
            .popover(for: $popover) { popover in
                popover.content
            }
        }
    }

    return MyView()
}
