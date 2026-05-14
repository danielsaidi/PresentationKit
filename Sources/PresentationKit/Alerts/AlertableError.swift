//
//  AlertableError.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by all error types that
/// can be used to generate an ``AlertMessage``.
///
/// When an ``ErrorAlerter`` type alerts an ``AlertableError``
/// using the ``SwiftUICore/View/alert(for:)`` modifier, the
/// ``AlertableError/alertMessage`` is automatically alerted,
/// while other errors will alert the localized description.
public protocol AlertableError: Error {

    associatedtype Actions: View
    associatedtype Message: View

    /// The alert message to display.
    var alertMessage: AlertMessage<Actions, Message> { get }
}

extension AlertableError {

    /// Convert the ``alertMessage`` to a type-erased one to
    /// work around generics constraints.
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
        if let alertError = item as? any AlertableError {
            return alertError.typeErasedAlertMessage.title
        }
        return "Error"
    }

    @ViewBuilder
    func alertActions(for item: any Error) -> some View {
        if let alertError = item as? any AlertableError {
            AnyView(alertError.typeErasedAlertMessage.actions())
        } else {
            Button("OK") {}
        }
    }

    @ViewBuilder
    func alertMessage(for item: any Error) -> some View {
        if let alertError = item as? any AlertableError {
            AnyView(alertError.typeErasedAlertMessage.message())
        } else {
            Text(item.localizedDescription)
        }
    }
}
