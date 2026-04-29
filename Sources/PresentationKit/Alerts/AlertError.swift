//
//  AlertError.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used to create an ``AlertMessage``.
public protocol AlertError: Error {

    associatedtype AlertActions: View
    associatedtype AlertMessage: View

    /// The alert message to display.
    var alertMessage: AlertMessage { get }
}
