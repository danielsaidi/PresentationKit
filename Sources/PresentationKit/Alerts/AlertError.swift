//
//  AlertError.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used to create an ``AlertMessage``.
public protocol AlertError: Error {

    associatedtype Actions: View
    associatedtype Message: View

    /// The alert message to display.
    var alertMessage: AlertMessage<Actions, Message> { get }
}

extension AlertError {

    var typeErasedAlertMessage: AlertMessage<AnyView, AnyView> {
        let message = alertMessage
        return AlertMessage(
            title: message.title,
            actions: { AnyView(message.actions()) },
            message: { AnyView(message.message()) }
        )
    }
}

// MARK: - View Extensions

public extension View {

    /// Presents an alert when the context item is set.
    ///
    /// This modifier tries to cast the item to ``AlertError``
    /// and uses its ``AlertError/alertMessage`` if it can. If
    /// the cast fails, a default alert is shown that uses the
    /// item's `localizedDescription` as the message.
    func alert<Item: Error>(
        for context: Binding<PresentationContext<Item>>
    ) -> some View {
        self.alert(
            alertTitle(for: context.wrappedValue.item),
            isPresented: Binding(
                get: { context.wrappedValue.item != nil },
                set: { if !$0 { context.wrappedValue.item = nil } }
            ),
            presenting: context.wrappedValue.item,
            actions: { alertActions(for: $0) },
            message: { alertMessage(for: $0) }
        )
    }

    func alertTitle(for item: (any Error)?) -> LocalizedStringKey {
        if let alertError = item as? any AlertError {
            return alertError.typeErasedAlertMessage.title
        }
        return "Error"
    }

    @ViewBuilder
    func alertActions(for item: any Error) -> some View {
        if let alertError = item as? any AlertError {
            AnyView(alertError.typeErasedAlertMessage.actions())
        } else {
            Button("OK") {}
        }
    }

    @ViewBuilder
    func alertMessage(for item: any Error) -> some View {
        if let alertError = item as? any AlertError {
            AnyView(alertError.typeErasedAlertMessage.message())
        } else {
            Text(item.localizedDescription)
        }
    }
}
