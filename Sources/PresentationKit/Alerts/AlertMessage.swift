//
//  AlertMessage.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to define an alert message.
public struct AlertMessage<Actions: View, Message: View> {

    public init(
        title: LocalizedStringKey,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder message: @escaping () -> Message
    ) {
        self.title = title
        self.actions = actions
        self.message = message
    }

    public init(
        title: String,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder message: @escaping () -> Message
    ) {
        self.init(
            title: LocalizedStringKey(stringLiteral: title),
            actions: actions,
            message: message
        )
    }

    public var title: LocalizedStringKey
    public var actions: () -> Actions
    public var message: () -> Message
}

public extension AlertMessage where Actions == Button<Text>, Message == EmptyView {

    init(title: LocalizedStringKey) {
        self.init(
            title: title,
            actions: { Button("OK") {} },
            message: { EmptyView() }
        )
    }

    init(title: String) {
        self.init(title: LocalizedStringKey(stringLiteral: title))
    }
}

public extension AlertMessage where Message == EmptyView {

    init(
        title: LocalizedStringKey,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.init(
            title: title,
            actions: actions,
            message: { EmptyView() }
        )
    }

    init(
        title: String,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.init(
            title: LocalizedStringKey(stringLiteral: title),
            actions: actions
        )
    }
}

public extension AlertMessage where Actions == Button<Text> {

    init(
        title: LocalizedStringKey,
        @ViewBuilder message: @escaping () -> Message
    ) {
        self.init(
            title: title,
            actions: { Button("OK") {} },
            message: message
        )
    }

    init(
        title: String,
        @ViewBuilder message: @escaping () -> Message
    ) {
        self.init(
            title: LocalizedStringKey(stringLiteral: title),
            message: message
        )
    }
}
