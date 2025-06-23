//
//  Image+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Image {

    static let alert = symbol("exclamationmark.triangle")
    static let fullScreenCover = symbol("rectangle.portrait.on.rectangle.portrait")
    static let sheet = symbol("rectangle.portrait.on.rectangle.portrait.angled")
    static let inlineSheet = symbol("inset.filled.bottomhalf.rectangle.portrait")

    private static func symbol(_ name: String) -> Image {
        Image(systemName: name)
    }
}
