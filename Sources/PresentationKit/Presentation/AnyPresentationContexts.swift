//
//  AnyPresentations.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2020-06-07.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

/// This class is inherited by various presentation contexts
/// that support view-based presentations.
///
/// Unlike the value-based presentation contexts, this class
/// lets you present a generic content type.
///
/// Use an `.alert`, `.fullScreenCover` or `.sheet` modifier
/// with a corresponding context class to inject the context
/// into the environment. You can then use the context value
/// to present alerts, covers, and sheets.
///
/// > Note: The "any" concept is kept for migration purposes,
/// since many apps rely on the old presentation contexts in
/// SwiftUIKit. Since item-based presentation is the SwiftUI
/// future, these contexts will be removed in the future.
open class AnyPresentation<Content>: ObservableObject {

    public init() {}

    /// Whether the context presentation is currently active.
    @Published
    public var isActive = false

    /// The content that is currently presented.
    @Published
    public internal(set) var content: (() -> Content)? {
        didSet { isActive = content != nil }
    }
}

@MainActor
public extension AnyPresentation {

    /// An ``isActive`` binding.
    var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }

    /// Dismiss the currently presented content.
    func dismiss() {
        DispatchQueue.main.async {
            self.isActive = false
        }
    }

    /// Present a content value.
    func presentContent(
        _ content: @autoclosure @escaping () -> Content
    ) {
        DispatchQueue.main.async {
            self.content = content
        }
    }
}


// MARK: - Alert

/// This context can be used to present alerts.
///
/// To use this class, just create a `@StateObject` instance
/// in your and bind it to any view, using the context-based
/// `.alert` modifier.
public class AnyAlertContext: AnyPresentation<Alert> {

    @MainActor
    public func present(
        _ alert: @autoclosure @escaping () -> Alert
    ) {
        presentContent(alert())
    }
}

public extension View {

    /// Set up context-based alerts for the view.
    func alert(
        _ context: AnyAlertContext
    ) -> some View {
        alert(
            isPresented: context.isActiveBinding,
            content: context.content ?? { Alert(title: Text("")) }
        )
        .environmentObject(context)
    }
}

public extension FocusedValues {

    @Entry var anyAlertContext: AnyAlertContext?
}


// MARK: - Full Screen Cover

/// This context can be used to present full screen covers.
///
/// To use this class, just create a `@StateObject` instance
/// in your and bind it to any view, using the context-based
/// `.fullScreenCover` modifier.
public class AnyFullScreenCoverContext: AnyPresentation<AnyView> {

    @MainActor
    public func present<Cover: View>(
        _ cover: @autoclosure @escaping () -> Cover
    ) {
        presentContent(AnyView(cover()))
    }
}

public extension View {

    /// Set up context-based full screen covers for the view.
    func fullScreenCover(
        _ context: AnyFullScreenCoverContext
    ) -> some View {
        #if os(iOS) || os(tvOS) || os(watchOS)
        fullScreenCover(
            isPresented: context.isActiveBinding,
            content: context.content ?? { AnyView(EmptyView()) }
        )
        .environmentObject(context)
        #else
        sheet(
            isPresented: context.isActiveBinding,
            content: context.content ?? { AnyView(EmptyView()) }
        )
        #endif
    }
}

public extension FocusedValues {

    @Entry var anyFullScreenCoverContext: AnyFullScreenCoverContext?
}


// MARK: - Sheet

/// This context can be used to present sheets.
///
/// To use this class, just create a `@StateObject` instance
/// in your and bind it to any view, using the context-based
/// `.sheet` modifier.
public class AnySheetContext: AnyPresentation<AnyView> {

    @MainActor
    public func present<Sheet: View>(
        _ sheet: @autoclosure @escaping () -> Sheet
    ) {
        presentContent(AnyView(sheet()))
    }
}

public extension View {

    /// Set up context-based sheets for the view.
    func sheet(_ context: AnySheetContext) -> some View {
        sheet(
            isPresented: context.isActiveBinding,
            content: context.content ?? { AnyView(EmptyView()) }
        )
        .environmentObject(context)
    }
}

public extension FocusedValues {

    @Entry var anySheetContext: AnySheetContext?
}
