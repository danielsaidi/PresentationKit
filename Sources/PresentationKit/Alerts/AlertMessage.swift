//
//  AlertMessage.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to define an alert.
public struct AlertMessage {

    public init(
        title: LocalizedStringResource,
        @ViewBuilder message: @escaping () -> some View,
        @ViewBuilder actions: @escaping () -> some View
    ) {
        self.title = String(localized: title)
        self.message = { AnyView(message()) }
        self.actions = { AnyView(actions()) }
    }

    public init(
        title: String,
        @ViewBuilder message: @escaping () -> some View,
        @ViewBuilder actions: @escaping () -> some View
    ) {
        self.title = title
        self.message = { AnyView(message()) }
        self.actions = { AnyView(actions()) }
    }

    public var title: String
    public var actions: () -> AnyView
    public var message: () -> AnyView
}

public extension AlertMessage {

    init(title: LocalizedStringResource) {
        self.init(title: String(localized: title))
    }

    init(title: String) {
        self.init(
            title: title,
            message: { EmptyView() },
            actions: { EmptyView() }
        )
    }

    init(
        title: LocalizedStringResource,
        @ViewBuilder message: @escaping () -> some View
    ) {
        self.init(
            title: String(localized: title),
            message: message
        )
    }

    init(
        title: String,
        @ViewBuilder message: @escaping () -> some View
    ) {
        self.init(
            title: title,
            message: message,
            actions: { Button("OK") {} }
        )
    }

    init(
        title: LocalizedStringResource,
        @ViewBuilder actions: @escaping () -> some View
    ) {
        self.init(
            title: String(localized: title),
            actions: actions
        )
    }

    init(
        title: String,
        @ViewBuilder actions: @escaping () -> some View
    ) {
        self.init(
            title: title,
            message: { EmptyView() },
            actions: actions
        )
    }
}
