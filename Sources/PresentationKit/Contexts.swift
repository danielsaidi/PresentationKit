//
//  Contexts.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol is implemented by the various presentation
/// context types.
///
/// The library will create a context instance of every type
/// and inject it into the view environment when you apply a
/// `.presentation(for: ...)` view modifier.
public protocol PresentationContext: AnyObject {
    associatedtype Model

    var value: Model? { get set }
}

public extension PresentationContext {

    /// Present the provided value.
    func present(_ value: Model) {
        self.value = value
    }
}

/// This type can be used to present alerts.
@Observable
public class AlertContext<Model>: PresentationContext {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}

/// This type can be used to present full screen covers.
@Observable
public class FullScreenCoverContext<Model>: PresentationContext {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}

/// This type can be used to manage sheet presentation state.
@Observable
public class SheetContext<Model>: PresentationContext {

    /// Create a new context instance.
    public init() {}

    /// The value to present.
    public var value: Model?
}
