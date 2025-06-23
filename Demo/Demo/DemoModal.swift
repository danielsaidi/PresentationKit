//
//  DemoModal.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

/// This view is used as a modal screen, for all full screen
/// covers and sheets.
///
/// Note that this view applies the demo presentation action
/// again, to ensure that all presentations that are used by
/// the demo are properly registered.
struct DemoModal: View {

    let value: DemoModel
    let title: LocalizedStringKey

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            DemoActions()
                .frame(minHeight: 250)
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Action.Dismiss", role: .cancel) {
                            dismiss()
                        }
                    }
                }
        }
        .withDemoPresentation()     // <- OBS
    }
}

#Preview {
    DemoPreview {
        DemoModal(
            value: .init(id: 1),
            title: "Title.Modal"
        )
    }
}
