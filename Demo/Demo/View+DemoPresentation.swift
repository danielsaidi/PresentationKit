//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

extension View {

    func withDemoPresentation() -> some View {
        self.presentation(
            for: DemoModel.self,
            alertContent: { value in
                AlertContent(
                    title: "Alert",
                    actions: {
                        Button("OK", action: { print("OK for item #\(value.id)") })
                        Button("Cancel", role: .cancel, action: {})
                    },
                    message: { Text("Alert for item #\(value.id)") }
                )
            },
            coverContent: {
                DemoModal(value: $0, title: "Cover")
            },
            sheetContent: { model in
                DemoModal(value: model, title: "Sheet")
                    .presentationDetents(model.prefersInlineSheetPresentation ? [.medium] : [])
            }
        )
    }
}
