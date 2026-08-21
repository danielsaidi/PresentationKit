//
//  NavigationDestination.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-08-03.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used as a navigation stack destination.
///
/// Use the ``SwiftUI/NavigationStack/init(root:navigation:)``
/// initializer or the ``NavigationDestinationStack`` to get
/// a stack that uses a certain navigation destination value.
public protocol NavigationDestination: Hashable {

    associatedtype DestinationContent: View

    /// The destination content view.
    var destinationContent: DestinationContent { get }
}

/// This content view is used within a navigation stack that
/// is created with a ``NavigationDestination``.
public struct NavigationDestinationContent<Destination: NavigationDestination>: View {

    let root: Destination
    let navigation: Navigation<Destination>

    public var body: some View {
        root.destinationContent
            .environment(navigation)
            .navigationDestination(for: Destination.self) {
                $0.destinationContent
            }
    }
}

// MARK: - Previews

private enum MyAppScreen: String, NavigationDestination {
    case home, settings

    @ViewBuilder
    var destinationContent: some View {
        switch self {
        case .home:
            NavigationLink(value: MyAppScreen.settings) {
                Text("Open Settings")
            }
        case .settings: Text("Settings")
        }
    }
}

#Preview {

    NavigationDestinationStack(
        root: MyAppScreen.home
    )
}
