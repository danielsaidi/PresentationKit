//
//  Navigation.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-20.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, renamed: "Navigation")
public typealias NavigationContext = Navigation

/// This type can be used to manage a value-based navigation
/// stack that can be bound to a `NavigationStack`.
///
/// You can bind the ``path`` value to a navigation stack of
/// the same type, then use ``push(_:)`` to push a new value
/// to the stack, ``pop()`` to remove the last value, etc.
///
/// You can extend `FocusedValues` with non-generic contexts
/// to be able to trigger navigations from e.g. the menu bar.
/// See the demo app for examples.
@Observable
public class Navigation<Model: Hashable> {

    /// Create a new navigation context instance.
    public init() {}

    /// The navigation path.
    public var path = [Model]()
}

public extension Navigation {

    @available(*, deprecated, renamed: "goBack(steps:)")
    func goBack(_ steps: Int) {
        goBack(steps: steps)
    }

    /// Go back a certain number of steps.
    func goBack(steps: Int) {
        path.removeLast(steps)
    }

    /// Go back a certain number of steps.
    func pop() {
        goBack(steps: 1)
    }

    /// Pop back to the root.
    func popToRoot() {
        path = []
    }

    /// Push a new value onto the stack.
    func push(_ value: Model) {
        path.append(value)
    }
}
