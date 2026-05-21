//
//  View+ToastDuration.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public struct ToastDuration {

    /// The default toast duration.
    static var defaultDuration: Double { 3 }
}

struct ToastDurationKey: PreferenceKey {
    static let defaultValue: Double? = nil
    static func reduce(value: inout Double?, nextValue: () -> Double?) {
        value = nextValue() ?? value
    }
}

public extension View {

    /// Apply an auto-dismiss duration to a toast content view.
    func toastDuration(seconds: Double) -> some View {
        preference(key: ToastDurationKey.self, value: seconds)
    }
}
