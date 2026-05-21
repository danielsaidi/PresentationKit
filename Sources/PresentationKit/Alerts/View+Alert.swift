//
//  View+Alert.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Presents an alert when the presentation is active.
    ///
    /// You must return an ``AlertMessage`` value to present
    /// an alert. Return `nil` if you don't want to show one
    /// for any item. This can be used to make a view handle
    /// a subset of many available alerts, e.g. when using a
    /// single enum for all available alerts in an app.
    func alert<Item: Identifiable>(
        for presentation: Binding<Presentation<Item>>,
        content: @escaping (Item) -> AlertMessage?
    ) -> some View {
        let item = presentation.wrappedValue.item
        let message = item.flatMap(content)
        return self.alert(
            message?.title ?? "",
            isPresented: Binding(
                get: { message != nil },
                set: { if !$0 { presentation.wrappedValue.item = nil } }
            ),
            presenting: message != nil ? item : nil,
            actions: { _ in message?.actions() },
            message: { _ in message?.message() }
        )
    }

    /// Presents an error alert when an error is active.
    ///
    /// This modifier tries to cast the item to ``AlertError``
    /// and uses its ``AlertError/alertMessage`` if possible.
    /// If the cast fails, a default alert is shown with the
    /// error's `localizedDescription` message.
    func alert<Item: Error>(
        for presentation: Binding<Presentation<Item>>
    ) -> some View {
        self.alert(
            for: presentation,
            defaultTitle: "Error"
        )
    }

    /// Presents an error alert when an error is active.
    ///
    /// This modifier tries to cast the item to ``AlertError``
    /// and uses its ``AlertError/alertMessage`` if possible.
    /// If the cast fails, a default alert is shown with the
    /// error's `localizedDescription` message. You can also
    /// customize the default values.
    @_disfavoredOverload
    func alert<Item: Error>(
        for presentation: Binding<Presentation<Item>>,
        defaultTitle: LocalizedStringResource? = nil,
        defaultMessage: LocalizedStringResource? = nil,
        defaultButtonTitle: LocalizedStringResource? = nil
    ) -> some View {
        self.alert(
            for: presentation,
            defaultTitle: defaultTitle?.localized(),
            defaultMessage: defaultMessage?.localized(),
            defaultButtonTitle: defaultButtonTitle?.localized()
        )
    }

    /// Presents an error alert when an error is active.
    ///
    /// This modifier tries to cast the item to ``AlertError``
    /// and uses its ``AlertError/alertMessage`` if possible.
    /// If the cast fails, a default alert is shown with the
    /// error's `localizedDescription` message. You can also
    /// customize the default values.
    @_disfavoredOverload
    func alert<Item: Error>(
        for presentation: Binding<Presentation<Item>>,
        defaultTitle: String? = nil,
        defaultMessage: String? = nil,
        defaultButtonTitle: String? = nil,
    ) -> some View {
        self.alert(
            alertTitle(for: presentation.wrappedValue.item, default: defaultTitle),
            isPresented: Binding(
                get: { presentation.wrappedValue.item != nil },
                set: { if !$0 { presentation.wrappedValue.item = nil } }
            ),
            presenting: presentation.wrappedValue.item,
            actions: { alertActions(for: $0, defaultButtonTitle: defaultButtonTitle) },
            message: { alertMessage(for: $0, default: defaultMessage) }
        )
    }
}

private extension LocalizedStringResource {

    func localized() -> String {
        String(localized: self)
    }
}

private extension View {

    func alertTitle(
        for item: (any Error)?,
        default: String?
    ) -> String {
        if let alertError = item as? any AlertableError {
            return alertError.alertMessage.title
        }
        return `default` ?? "Error"
    }

    @ViewBuilder
    func alertActions(
        for item: any Error,
        defaultButtonTitle: String?
    ) -> some View {
        if let alertError = item as? any AlertableError {
            alertError.alertMessage.actions()
        } else {
            Button(defaultButtonTitle ?? "OK") {}
        }
    }

    @ViewBuilder
    func alertMessage(
        for item: any Error,
        default: String?
    ) -> some View {
        if let alertError = item as? any AlertableError {
            alertError.alertMessage.message()
        } else {
            Text(`default` ?? item.localizedDescription)
        }
    }
}
