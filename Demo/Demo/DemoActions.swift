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
struct DemoActions: View, ErrorAlerter {

    @Environment(AlertContext<DemoModel>.self) var alert
    @Environment(FullScreenCoverContext<DemoModel>.self) var cover
    @Environment(AlertContext<DemoError>.self) var errorAlertContext
    @Environment(SheetContext<DemoModel>.self) var sheet

    var body: some View {
        NavigationStack {
            List {
                Section("Actions.Presentation") {
                    DemoPresentationActions(
                        alert: alert,
                        cover: cover,
                        sheet: sheet
                    )
                }
                Section("Actions.ErrorHandling") {
                    Button {
                        tryWithErrorAlert(performFailingOperation)
                    } label: {
                        label("Action.PerformFailingOperation", .alert)
                    }
                }
            }
            .focusable()
            .focusedValue(\.demoModelAlertContext, alert)
            .focusedValue(\.demoModelCoverContext, cover)
            .focusedValue(\.demoModelSheetContext, sheet)
            .buttonStyle(.borderless)
        }
    }
}

struct DemoPresentationActions: View {

    var alert: AlertContext<DemoModel>?
    var cover: FullScreenCoverContext<DemoModel>?
    var sheet: SheetContext<DemoModel>?

    var body: some View {
        Group {
            Button {
                alert?.present(.init(id: 1))
            } label: {
                label("Action.PresentAlert", .alert)
            }
            #if !os(macOS)
            Button {
                cover?.present(.init(id: 2))
            } label: {
                label("Action.PresentFullScreenCover", .fullScreenCover)
            }
            #endif
            Button {
                sheet?.present(.init(id: 3))
            } label: {
                label("Action.PresentSheet", .sheet)
            }
            Button {
                sheet?.present(.prefersInlineSheetPresentation)
            } label: {
                label("Action.PresentInlineSheet", .inlineSheet)
            }
        }
        // .disabled(isDisabled)
    }
}

private extension DemoPresentationActions {

    var isDisabled: Bool {
        alert != nil || cover != nil || sheet != nil
    }
}

private extension View {

    func label(_ title: LocalizedStringKey, _ image: Image) -> some View {
        Label {
            Text(title)
        } icon: {
            image
        }
    }

    func performFailingOperation() async throws {
        throw DemoError.demoError
    }
}

#Preview {
    DemoPreview {
        DemoActions()
    }
}
