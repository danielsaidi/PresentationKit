//
//  AlertableError.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by all error types that
/// can be used to generate an ``AlertMessage``.
///
/// When an ``ErrorAlerter`` type alerts an ``AlertableError``
/// using the ``SwiftUICore/View/alert(for:)`` modifier, the
/// ``AlertableError/alertMessage`` is automatically alerted,
/// while other errors will alert the localized descriptions.
public protocol AlertableError: Error {

    /// The alert message to display.
    var alertMessage: AlertMessage { get }
}
