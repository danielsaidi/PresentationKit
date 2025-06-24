//
//  ValuePresentation.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol is implemented by the various presentation
/// context types that support value-based presentations.
///
/// Use a `.presentation(for: ...)` view modifier to apply a
/// context-based presentation strategy to the app root view.
public protocol ValuePresentation: AnyObject {

    associatedtype Model

    var value: Model? { get set }
}

public extension ValuePresentation {

    /// Present the provided value.
    func present(_ value: Model) {
        self.value = value
    }
}

/// This context can be used to present alerts.
@Observable
public class AlertContext<Model>: ValuePresentation {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}

/// This context can be used to present full screen covers.
@Observable
public class FullScreenCoverContext<Model>: ValuePresentation {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}

/// This context can be used to present sheets.
@Observable
public class SheetContext<Model>: ValuePresentation {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}
