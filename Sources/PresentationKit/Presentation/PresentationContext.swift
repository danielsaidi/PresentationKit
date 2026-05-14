//
//  PresentationContext.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

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
}

// MARK: - View Extensions

public extension View {

    /// Presents an alert when the context item is set.
    ///
    /// The ``AlertMessage`` struct has several mutations to
    /// let you create different kinds of messages.
    func alert<Item: Identifiable, Actions: View, Message: View>(
        for context: Binding<PresentationContext<Item>>,
        content: @escaping (Item) -> AlertMessage<Actions, Message>
    ) -> some View {
        self.alert(
            context.wrappedValue.item.map(content)?.title ?? "",
            isPresented: Binding(
                get: { context.wrappedValue.item != nil },
                set: { if !$0 { context.wrappedValue.item = nil } }
            ),
            presenting: context.wrappedValue.item,
            actions: { item in content(item).actions() },
            message: { item in content(item).message() }
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

        @State var alertContext = PresentationContext<MyContent>()
        @State var coverContext = PresentationContext<MyContent>()
        @State var sheetContext = PresentationContext<MyContent>()

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
                AlertMessage(title: content.id)
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
