//
//  ErrorAlertConvertible.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any error types that
/// should can be used together with an ``ErrorAlerter``.
///
/// By implementing this protocl, an error type can define a
/// custom title, message and button text.
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
    var errorAlert: Alert {
        Alert(
            title: Text(alertTitle),
            message: Text(alertMessage),
            dismissButton: .default(Text(alertButtonText))
        )
    }
}
