//
//  Toast.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// A view that wraps content in a capsule-shaped toast style.
public struct Toast<Content: View>: View {

    public init(
        style: ToastStyle = .standard,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.content = content()
    }

    private let style: ToastStyle
    private let content: Content

    public var body: some View {
        content
            .background(style.background, in: .capsule)
            .shadow(style.shadow)
    }
}

/// This style defines the visual style of a ``Toast``.
public struct ToastStyle {

    public init(
        background: AnyShapeStyle = AnyShapeStyle(.thinMaterial),
        shadow: ToastShadowStyle = .default
    ) {
        self.background = background
        self.shadow = shadow
    }

    public var background: AnyShapeStyle
    public var shadow: ToastShadowStyle
}

public extension ToastStyle {
    static var standard: ToastStyle { .init() }
}

/// This style defines the shadow of a ``Toast``.
public struct ToastShadowStyle {

    public init(
        color: Color,
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }

    public var color: Color
    public var radius: CGFloat
    public var x: CGFloat
    public var y: CGFloat
}

public extension ToastShadowStyle {

    /// The default shadow style is a discrete shadow.
    static var `default`: ToastShadowStyle { .init(color: .black.opacity(0.15), radius: 8, y: 4) }

    /// This shadow style disables the toast shadow.
    static var noShadow: ToastShadowStyle { .init(color: .clear, radius: 0) }
}

private extension View {

    func shadow(_ style: ToastShadowStyle) -> some View {
        shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
}
