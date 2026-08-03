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

@MainActor
public extension NavigationStack {

    /// Create a navigation stack with a generic destination
    /// and a ``Navigation`` that is used to manage the path.
    ///
    /// The view will be set up for the destination type and
    /// inject the ``Navigation`` value into the environment.
    init<Destination: NavigationDestination>(
        root: Destination,
        navigation: Navigation<Destination>
    ) where Data == [Destination], Root == NavigationDestinationContent<Destination> {
        self.init(path: Bindable(navigation).path) {
            NavigationDestinationContent(
                root: root,
                navigation: navigation
            )
        }
    }
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

/// This view can be used as a `NavigationStack` alternative.
///
/// Unlike the ``SwiftUI/NavigationStack`` initializer, this
/// view uses an optional ``Navigation`` parameter, and will
/// create an internal navigation state if you don't provide
/// a custon one.
///
/// The view will be configured for the destination type and
/// inject the ``Navigation`` value into the environment.
public struct NavigationDestinationStack<Destination: NavigationDestination>: View {

    /// Create a navigation stack with a generic destination
    /// and an optional ``Navigation`` to manage the path.
    ///
    /// - Parameters:
    ///   - root: The root destination.
    ///   - navigation: The navigation value to use, if any.
    public init(
        root: Destination,
        navigation: Navigation<Destination>? = nil
    ) {
        self.root = root
        self.navigation = navigation
    }

    private let root: Destination
    private let navigation: Navigation<Destination>?

    @State private var internalNavigation = Navigation<Destination>()

    private var resolvedNavigation: Navigation<Destination> {
        navigation ?? internalNavigation
    }

    public var body: some View {
        NavigationStack(path: Bindable(resolvedNavigation).path) {
            NavigationDestinationContent(
                root: root,
                navigation: resolvedNavigation
            )
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
