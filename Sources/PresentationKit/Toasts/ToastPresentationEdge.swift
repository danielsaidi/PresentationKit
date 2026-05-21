//
//  ToastPresentationEdge.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines the edge from which a toast slides in.
///
/// Pass it to the ``SwiftUICore/View/toast(for:edge:content:)``
/// modifier to control which edge the toast animates from.
public enum ToastPresentationEdge: Sendable {
    case top, bottom
}

extension ToastPresentationEdge {

    var swiftUIEdge: Edge {
        switch self {
        case .top: .top
        case .bottom: .bottom
        }
    }

    var alignment: Alignment {
        switch self {
        case .top: .top
        case .bottom: .bottom
        }
    }

    #if !os(tvOS) && !os(watchOS)
    func dismissSwipe(action: @escaping () -> Void) -> some Gesture {
        DragGesture(minimumDistance: 20)
            .onEnded { value in
                switch self {
                case .top: if value.translation.height < 0 { action() }
                case .bottom: if value.translation.height > 0 { action() }
                }
            }
    }
    #endif
}
