//
//  NavigationChevron.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-20.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view mimic the native navigation chevron that is used in lists.
public struct NavigationChevron: View {

    public init() {}

        @Environment(\.navigationChevronStyle) var style

    public var body: some View {
        Image(systemName: "chevron.right")
            .font(style.font)
            .foregroundStyle(style.color)
            .padding(.leading, style.padding)
            .scaleEffect(style.scale)
    }
}

// MARK: - Style

public struct NavigationChevronStyle {
    public init(
        font: Font = standardFont,
        color: Color = .secondary.opacity(0.6),
        padding: Double = 2,
        scale: Double = standardScale
    ) {
        self.font = font
        self.color = color
        self.padding = padding
        self.scale = scale
    }

    public var font: Font
    public var color: Color
    public var padding: Double
    public var scale: Double
}

public extension NavigationChevronStyle {

    static var standard: Self { .init() }
}

public extension NavigationChevronStyle {

    static var standardFont: Font {
        #if os(tvOS)
        Font.caption.weight(.bold)
        #else
        Font.footnote.weight(.semibold)
        #endif
    }

    static var standardScale: Double {
        #if os(iOS)
        1.05
        #elseif os(tvOS)
        0.95
        #else
        1.00
        #endif
    }
}

// MARK: - Environment

private extension EnvironmentValues {

    @Entry var navigationChevronStyle: NavigationChevronStyle = .standard
}

public extension View {

    func navigationChevronStyle(_ style: NavigationChevronStyle) -> some View {
        environment(\.navigationChevronStyle, style)
    }
}
