//
//  NavigationContext.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-20.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to manage navigation stack paths.
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

    /// Push a new value onto the stack.
    func push(_ value: Model) {
        path.append(value)
    }
}
