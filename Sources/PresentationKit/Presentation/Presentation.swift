//
//  Presentation.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, renamed: "Presentation")
public typealias PresentationContext = Presentation

/// This type can be used to manage an observed presentation
/// state that can be bound to a modal, a sheet, etc.
///
/// You can use the ``item`` value with a view modifier like
/// `.sheet(item:content:)` to perform the presentation when
/// the ``item`` is set by either setting the property or by
/// using the ``present(_:)`` function.
///
/// You can extend `FocusedValues` with non-generic contexts
/// to be able to trigger presentations from e.g. a menu bar.
/// See the demo app for examples.
@Observable
public final class Presentation<ItemType> {

    /// Create a new context instance.¬
    public init() {}

    /// The value to present.
    public var item: ItemType?
}

public extension Presentation {

    /// Present the provided value.
    func present(_ item: ItemType) {
        self.item = item
    }

    /// Dismiss the currently presented value.
    func dismiss() {
        self.item = nil
    }
}

// MARK: - Previews

#Preview {

    return MyView()

    enum MyContent: String, @MainActor Identifiable, View {
        case red, green, blue

        var id: String { rawValue.capitalized }

        var body: some View {
            switch self {
            case .red: Color.red
            case .green: Color.green
            case .blue: Color.blue
            }
        }
    }

    struct MyView: View {

        @State var alertContext = Presentation<MyContent>()
        @State var coverContext = Presentation<MyContent>()
        @State var sheetContext = Presentation<MyContent>()

        var body: some View {
            List {
                Button("Present Red Alert") {
                    alertContext.present(.red)
                }
                Button("Present Green Cover") {
                    coverContext.present(.green)
                }
                Button("Present Blue Sheet") {
                    sheetContext.present(.blue)
                }
            }
            .alert(for: $alertContext) { content in
                switch content {
                case .red:
                    AlertMessage(
                        title: LocalizedStringResource(stringLiteral: content.id),
                        message: { EmptyView() },
                        actions: {
                            Button("Cancel", role: .cancel) {}
                            Button("OK", role: .none) {}
                        }
                    )
                default: nil
                }
            }
            #if !os(macOS)
            .fullScreenCover(for: $coverContext) { content in
                content
            }
            #endif
            .sheet(for: $sheetContext) { content in
                content
            }
        }
    }
}
