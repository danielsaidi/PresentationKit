//
//  NavigationContext.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-20.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This alias makes ``NavigationContext`` easier to use.
public typealias Navigation = NavigationContext

/// This type can be used to manage a value-based navigation.
///
/// > Tip: For less code, use the ``Navigation`` typealias.
@Observable
public class NavigationContext<Model: Hashable> {

    /// Create a new navigation context instance.
    public init() {}

    /// The navigation path.
    public var path = [Model]()
}

public extension NavigationContext {

    /// Go back a certain number of steps.
    func goBack(_ steps: Int) {
        path.removeLast(steps)
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
