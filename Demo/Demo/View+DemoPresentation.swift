//
//  View+DemoPresentation.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

extension View {

    /// This function applies all required presentations for
    /// the demo.
    ///
    /// This must be added to both the root view, as well as
    /// all modals, to ensure that the required context will
    /// be available to every new presentation layer.
    func withDemoPresentation() -> some View {
        self
            .presentation(
                standardErrorAlertFor: DemoError.self
            )
            .presentation(
                for: DemoModel.self,
                alertContent: { value in
                    AlertContent(
                        title: "Title.Alert",
                        actions: {
                            Button("Action.OK", action: { print("OK for item #\(value.id)") })
                            Button("Action.Cancel", role: .cancel, action: {})
                        },
                        message: { Text("Message.AlertForItem.\(value.id)") }
                    )
                },
                fullScreenCoverContent: {
                    DemoModal(value: $0, title: "Title.Cover")
                },
                sheetContent: { model in
                    DemoModal(value: model, title: "Title.Sheet")
                        .presentationDetents(model.prefersInlineSheetPresentation ? [.medium] : [])
                }
            )
    }
}
