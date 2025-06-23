//
//  DemoActions.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

/// This list contains demo-related actions that are used in
/// both the root view and in modals.
struct DemoActions: View {

    @Environment(AlertContext<DemoModel>.self) var alert
    @Environment(FullScreenCoverContext<DemoModel>.self) var cover
    @Environment(SheetContext<DemoModel>.self) var sheet

    private let value = DemoModel(id: 1)

    var body: some View {
        NavigationStack {
            List {
                Section("Presentation") {
                    Button {
                        alert.present(.init(id: 1))
                    } label: {
                        label("Present an alert", "exclamationmark.triangle")
                    }
                    #if !os(macOS)
                    Button {
                        cover.present(.init(id: 2))
                    } label: {
                        label("Present a full screen modal", "rectangle.portrait.on.rectangle.portrait")
                    }
                    #endif
                    Button {
                        sheet.present(.init(id: 3))
                    } label: {
                        label("Present a sheet", "rectangle.portrait.on.rectangle.portrait.angled")
                    }
                    Button {
                        sheet.present(.prefersInlineSheetPresentation)
                    } label: {
                        label("Present an inline sheet", "inset.filled.bottomhalf.rectangle.portrait")
                    }
                }
            }
            .focusable()
            .focusedValue(\.demoModelAlertContext, alert)
            .focusedValue(\.demoModelCoverContext, cover)
            .focusedValue(\.demoModelSheetContext, sheet)
        }
    }
}

private extension View {

    func label(_ title: String, _ systemImageName: String) -> some View {
        Label(
            title,
            systemImage: systemImageName
        )
    }
}

#Preview {
    DemoPreview {
        DemoActions()
    }
}
