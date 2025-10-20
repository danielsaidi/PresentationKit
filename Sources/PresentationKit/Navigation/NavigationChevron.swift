//
//  NavigationChevron.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-20.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view mimic the native navigation chevron that is used in lists.
public struct NavigationChevron: View {

    public init() {}

    public var body: some View {
        Image(systemName: "chevron.right")
            .font(font)
            .opacity(opacity)
            .padding(.leading, padding)
            .scaleEffect(scale)
    }
}

extension NavigationChevron {

    var font: Font {
        #if os(iOS)
        Font.footnote.weight(.semibold)
        #elseif os(tvOS)
        Font.caption.weight(.bold)
        #else
        Font.footnote.weight(.semibold)
        #endif
    }
    
    var opacity: Double { 0.25 }

    var padding: Double { 2 }

    var scale: Double {
        #if os(iOS)
        1.05
        #elseif os(tvOS)
        0.95
        #else
        1.00
        #endif
    }
}
