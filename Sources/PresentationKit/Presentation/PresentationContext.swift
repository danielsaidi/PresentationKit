//
//  PresentationContext.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This alias makes ``PresentationContext`` easier to use.
public typealias Presentation = PresentationContext

/// This class can store generic values that are meant to be
/// presented in e.g. an alert, modal or sheet.
///
/// You can bind the context ``item`` value to a native view
/// modifier like `.sheet(item:content:)`, or use any of the
/// context-specific versions of the modifiers. You can then
/// use ``item`` or ``present(_:)`` to present items.
///
/// You can extend `FocusedValues` with non-generic contexts
/// to be able to trigger scene presentations from the macOS
/// menu bar. See the demo app for examples.
///
/// > Tip: For less code, use the ``Presentation`` typealias.
@Observable
public final class PresentationContext<ItemType> {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var item: ItemType?
}

public extension PresentationContext {

    /// Present the provided value.
    func present(_ item: ItemType) {
        self.item = item
    }

    /// Dismiss the currently presented value.
    func dismiss() {
        self.item = nil
    }
}

// MARK: - View Extensions

public extension View {

    /// Presents an alert when the context item is set.
    ///
    /// You must return an ``AlertMessage`` value to present
    /// an alert. Return `nil` if you don't want to show one
    /// for any item. This can be used to make a view handle
    /// a subset of many available alerts, e.g. when using a
    /// single enum for all available alerts in an app.
    func alert<Item: Identifiable>(
        for context: Binding<PresentationContext<Item>>,
        content: @escaping (Item) -> AlertMessage?
    ) -> some View {
        let item = context.wrappedValue.item
        let message = item.flatMap(content)
        return self.alert(
            message?.title ?? "",
            isPresented: Binding(
                get: { message != nil },
                set: { if !$0 { context.wrappedValue.item = nil } }
            ),
            presenting: message != nil ? item : nil,
            actions: { _ in message?.actions() },
            message: { _ in message?.message() }
        )
    }

    #if !os(macOS)
    /// Presents a cover when the context item is set.
    func fullScreenCover<Item: Identifiable, Content: View>(
        for context: Binding<PresentationContext<Item>>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping (Item) -> Content
    ) -> some View {
        self.fullScreenCover(
            item: context.item,
            onDismiss: onDismiss,
            content: content
        )
    }
    #endif

    /// Presents a sheet when the context item is set.
    func sheet<Item: Identifiable, Content: View>(
        for context: Binding<PresentationContext<Item>>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping (Item) -> Content
    ) -> some View {
        self.sheet(
            item: context.item,
            onDismiss: onDismiss,
            content: content
        )
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
