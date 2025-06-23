//
//  DemoModal.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

struct DemoModal: View {

    let value: DemoModel
    let title: String

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            DemoActions()
                .frame(minHeight: 250)
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Dismiss", role: .cancel) {
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    DemoPreview {
        DemoModal(
            value: .init(id: 1),
            title: "Modal"
        )
    }
}
