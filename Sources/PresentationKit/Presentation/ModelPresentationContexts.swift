//
//  ModelPresentationContexts.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol is implemented by the various presentation contexts that support
/// value-based presentations.
///
/// Use the various `.presentation(for: ...)` view modifiers to apply any
/// context-based presentation strategy to the app root view.
public protocol ModelPresentation: AnyObject {

    associatedtype Model

    var value: Model? { get set }
}

public extension ModelPresentation {

    /// Present the provided value.
    func present(_ value: Model) {
        self.value = value
    }
}

/// This context can be used to present alerts.
@Observable
public final class AlertContext<Model>: ModelPresentation {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}

/// This context can be used to present full screen covers.
@Observable
public final class FullScreenCoverContext<Model>: ModelPresentation {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}

/// This context can be used to present sheets.
@Observable
public final class SheetContext<Model>: ModelPresentation {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}
