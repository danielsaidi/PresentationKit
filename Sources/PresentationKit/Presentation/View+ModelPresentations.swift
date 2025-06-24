//
//  View+ModelPresentations.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Register a presentation strategy for a certain error
    /// type, with no modal presentation logic.
    func presentation<Model: Error, AlertActions: View, AlertMessage: View>(
        for model: Model.Type,
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>
    ) -> some View {
        self.modifier(
            AlertModifier(
                alertContent: alertContent
            )
        )
    }

    /// Register a presentation strategy for a certain error
    /// type, with no modal presentation logic.
    func presentation<Model: ErrorAlertConvertible>(
        standardAlertFor model: Model.Type
    ) -> some View {
        self.modifier(
            ErrorAlertModifier<Model>()
        )
    }

    /// Register a presentation strategy for a certain model,
    /// with the same view for full screen covers and sheets.
    func presentation<Model: Identifiable, AlertActions: View, AlertMessage: View, ModalContent: View>(
        for model: Model.Type,
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>,
        modalContent: @escaping (Model) -> ModalContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: alertContent,
                coverContent: modalContent,
                sheetContent: modalContent
            )
        )
    }

    /// Register a presentation strategy for a certain model,
    /// with different views for full screen covers and sheets.
    func presentation<Model: Identifiable, AlertActions: View, AlertMessage: View, CoverContent: View, SheetContent: View>(
        for model: Model.Type,
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>,
        fullScreenCoverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: alertContent,
                coverContent: fullScreenCoverContent,
                sheetContent: sheetContent
            )
        )
    }

    /// Register a presentation strategy for a certain model,
    /// with the same view for full screen covers and sheets.
    func presentation<Model: Identifiable, ModalContent: View>(
        for model: Model.Type,
        modalContent: @escaping (Model) -> ModalContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: { _ in AlertContent.empty() },
                coverContent: modalContent,
                sheetContent: modalContent
            )
        )
    }

    /// Register a presentation strategy for a certain model.
    func presentation<Model: Identifiable, CoverContent: View, SheetContent: View>(
        for model: Model.Type,
        coverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: { _ in AlertContent.empty() },
                coverContent: coverContent,
                sheetContent: sheetContent
            )
        )
    }
}

struct AlertModifier<Model, AlertActions: View, AlertMessage: View>: ViewModifier {

    init(
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>
    ) {
        self.alertContent = alertContent
    }

    let alertContent: (Model) -> AlertContent<AlertActions, AlertMessage>

    @State var alertContext = AlertContext<Model>()

    public func body(content: Content) -> some View {
        content
            .environment(alertContext)
            .alert(
                alertTitle,
                isPresented: .init(
                    get: { alertContext.value != nil },
                    set: {
                        if $0 {
                        } else {
                            alertContext.value = nil
                        }
                    }
                ),
                presenting: alertContext.value,
                actions: { alertContent($0).actions() },
                message: { alertContent($0).message() }
            )
    }
}

private extension AlertModifier {

    var alertTitle: LocalizedStringKey {
        guard let val = alertContext.value else { return "" }
        return alertContent(val).title
    }
}

struct ErrorAlertModifier<Model: ErrorAlertConvertible>: ViewModifier {

    @State var alertContext = AlertContext<Model>()

    public func body(content: Content) -> some View {
        content
            .environment(alertContext)
            .alert(
                alertContext.value?.alertTitle ?? "",
                isPresented: .init(
                    get: { alertContext.value != nil },
                    set: {
                        if $0 {
                        } else {
                            alertContext.value = nil
                        }
                    }
                ),
                presenting: alertContext.value,
                actions: { value in Button(value.alertButtonText, action: {}) },
                message: { value in Text(value.alertMessage) }
            )
    }
}

struct PresentationModifier<Model: Identifiable, AlertActions: View, AlertMessage: View, CoverContent: View, SheetContent: View>: ViewModifier {

    init(
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>,
        coverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) {
        self.alertContent = alertContent
        self.coverContent = coverContent
        self.sheetContent = sheetContent
    }

    let alertContent: (Model) -> AlertContent<AlertActions, AlertMessage>
    let coverContent: (Model) -> CoverContent
    let sheetContent: (Model) -> SheetContent

    @State var alertContext = AlertContext<Model>()
    @State var coverContext = FullScreenCoverContext<Model>()
    @State var sheetContext = SheetContext<Model>()

    public func body(content: Content) -> some View {
        content
            .environment(alertContext)
            .environment(coverContext)
            .environment(sheetContext)
            .alert(
                alertTitle,
                isPresented: .init(
                    get: { alertContext.value != nil },
                    set: {
                        if $0 {
                        } else {
                            alertContext.value = nil
                        }
                    }
                ),
                presenting: alertContext.value,
                actions: { alertContent($0).actions() },
                message: { alertContent($0).message() }
            )
            #if !os(macOS)
            .fullScreenCover(item: $coverContext.value, content: cover)
            #endif
            .sheet(item: $sheetContext.value, content: sheet)
    }
}

private extension PresentationModifier {

    var alertTitle: LocalizedStringKey {
        guard let val = alertContext.value else { return "" }
        return alertContent(val).title
    }

    func cover(for value: Model) -> some View {
        coverContent(value)
            .presentation(
                for: Model.self,
                alertContent: alertContent,
                fullScreenCoverContent: coverContent,
                sheetContent: sheetContent
            )
    }

    func sheet(for value: Model) -> some View {
        sheetContent(value)
            .presentation(
                for: Model.self,
                alertContent: alertContent,
                fullScreenCoverContent: coverContent,
                sheetContent: sheetContent
            )
    }
}


// MARK: - Preview

private struct Model: Identifiable {

    let id: Int
}

private struct MyApp: View {

    var body: some View {
        ContentView()
            .presentation(
                for: Model.self,
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
                fullScreenCoverContent: {
                    ModalView(value: $0, title: "Cover")
                },
                sheetContent: {
                    ModalView(value: $0, title: "Sheet")
                }
            )
    }
}

private struct ContentView: View {

    @Environment(AlertContext<Model>.self) var alert
    @Environment(FullScreenCoverContext<Model>.self) var cover
    @Environment(SheetContext<Model>.self) var sheet

    let value = Model(id: 1)

    var body: some View {
        NavigationStack {
            List {
                Button("Present an alert") {
                    alert.present(value)
                }
                Button("Present a full screen cover") {
                    cover.present(value)
                }
                Button("Present a sheet") {
                    sheet.present(value)
                }
            }
            .navigationTitle("Demo")
        }
    }
}

private struct ModalView: View {

    let value: Model
    let title: String

    @Environment(\.dismiss) var dismiss

    @Environment(AlertContext<Model>.self) var alert
    @Environment(FullScreenCoverContext<Model>.self) var cover
    @Environment(SheetContext<Model>.self) var sheet

    var body: some View {
        NavigationStack {
            List {
                Button("Present another alert") {
                    alert.present(value)
                }
                Button("Present another full screen cover") {
                    cover.present(value)
                }
                Button("Present another sheet") {
                    sheet.present(value)
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Dismiss", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview("Documentation") {

    MyApp()
}
