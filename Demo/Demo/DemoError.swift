//
//  DemoError.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

enum DemoError: ErrorAlertConvertible, LocalizedError {

    case demoError, raw(Error)
}

extension DemoError {

    var id: String {
        switch self {
        case .demoError: "demoError"
        case .raw(let error): String(describing: error)
        }
    }

    var alertTitle: String {
        switch self {
        case .demoError: "Demo Error"
        case .raw: "Error"
        }
    }

    var alertMessage: String {
        errorDescription
    }

    var alertButtonText: String {
        "OK"
    }

    var errorDescription: String {
        switch self {
        case .demoError: "This is a demo error."
        case .raw(let error): String(describing: error)
        }
    }
}
