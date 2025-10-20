//
//  ErrorAlertConvertible.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by error types that should be able to create
/// their own ``errorAlert``.
///
/// By implementing this protocol, a type can define a custom alert title, message,
/// and button text. You can use ``SwiftUICore/View/presentation(for:)``
/// to set up a presentation strategy that uses your specific error type.
public protocol ErrorAlertConvertible: Error {

    /// The title to display in the alert.
    var alertTitle: String { get }

    /// The message to display in the alert.
    var alertMessage: String { get }

    /// The text to use for the alert button.
    var alertButtonText: String { get }
}

public extension ErrorAlertConvertible {

    /// Create an error `Alert` for the type.
    var errorAlert: Alert {
        Alert(
            title: Text(alertTitle),
            message: Text(alertMessage),
            dismissButton: .default(Text(alertButtonText))
        )
    }
}
