//
//  ValuePresentationModels.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to define alert content.
public struct AlertContent<Actions: View, Message: View> {

    public init(
        title: LocalizedStringKey,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder message: @escaping () -> Message
    ) {
        self.title = title
        self.actions = actions
        self.message = message
    }

    public var title: LocalizedStringKey
    public var actions: () -> Actions
    public var message: () -> Message

    static func empty() -> Self where Actions == EmptyView, Message == EmptyView {
        .init(
            title: "",
            actions: { EmptyView() },
            message: { EmptyView() }
        )
    }
}
