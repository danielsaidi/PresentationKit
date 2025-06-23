//
//  DemoModel.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

struct DemoModel: Equatable, Identifiable {

    let id: Int
}

extension DemoModel {

    var prefersInlineSheetPresentation: Bool {
        self == .prefersInlineSheetPresentation
    }

    static var prefersInlineSheetPresentation: Self {
        self.init(id: 1_000)
    }
}

extension FocusedValues {

    @Entry var demoModelAlertContext: AlertContext<DemoModel>?
    @Entry var demoModelCoverContext: FullScreenCoverContext<DemoModel>?
    @Entry var demoModelSheetContext: SheetContext<DemoModel>?
}
