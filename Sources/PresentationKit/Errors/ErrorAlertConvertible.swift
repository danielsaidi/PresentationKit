//
//  ErrorAlertConvertible.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any error types that
/// can be used with an ``ErrorAlerter``.
///
/// By implementing this protocol, a type can define its own
/// alert title, message and button text. You can then apply
/// the ``SwiftUICore/View/presentation(for:)`` modifier, to
/// set up a presentation strategy that uses your error type
/// to define the alert content.
public protocol ErrorAlertConvertible: Error {

    /// The title to display in the alert.
    var alertTitle: String { get }

    /// The message to display in the alert.
    var alertMessage: String { get }

    /// The text to use for the alert button.
    var alertButtonText: String { get }
}

public extension ErrorAlertConvertible {

    /// Create an error `Alert`.
    ///
    /// This can be used
    var errorAlert: Alert {
        Alert(
            title: Text(alertTitle),
            message: Text(alertMessage),
            dismissButton: .default(Text(alertButtonText))
        )
    }
}
