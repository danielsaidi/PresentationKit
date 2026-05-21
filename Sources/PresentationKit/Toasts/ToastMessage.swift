//
//  ToastMessage.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// A toast view that presents a text message.
public struct ToastMessage: View {

    public init(_ message: String) {
        self.message = message
    }

    public init(_ message: LocalizedStringResource) {
        self.message = .init(localized: message)
    }

    private let message: String

    public var body: some View {
        Toast {
            Text(message)
                .padding()
        }
    }
}
