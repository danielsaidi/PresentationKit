//
//  View+Toast.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Presents a toast when the presentation is active.
    ///
    /// The toast slides in from the provided `edge`, which
    /// defaults to `.top`.
    func toast<Item: Identifiable, Content: View>(
        for presentation: Binding<Presentation<Item>>,
        edge: ToastPresentationEdge = .top,
        content: @escaping (Item) -> Content
    ) -> some View {
        self.modifier(
            ToastModifier(presentation: presentation, edge: edge, content: content)
        )
    }
}

private struct ToastModifier<Item: Identifiable, ToastContent: View>: ViewModifier {

    @Binding var presentation: Presentation<Item>
    let edge: ToastPresentationEdge
    let content: (Item) -> ToastContent

    @State private var visibleItem: Item?
    @State private var dismissTask: Task<Void, Never>?
    @State private var duration: Double = ToastDuration.defaultDuration

    func body(content: Content) -> some View {
        content.overlay(alignment: edge.alignment) {
            if let item = visibleItem {
                self.content(item)
                    .transition(.move(edge: edge.swiftUIEdge).combined(with: .opacity))
                    #if !os(tvOS) && !os(watchOS)
                    .gesture(edge.dismissSwipe { dismiss() })
                    #endif
                    .onPreferenceChange(ToastDurationKey.self) { duration = $0 ?? ToastDuration.defaultDuration }
                    .onAppear { scheduleDismiss(after: duration) }
            }
        }
        .animation(.bouncy, value: visibleItem == nil)
        .onChange(of: presentation.item?.id) { _, newID in
            dismissTask?.cancel()
            guard newID != nil else {
                visibleItem = nil
                return
            }
            guard visibleItem != nil else {
                visibleItem = presentation.item
                return
            }
            // An item is already visible — dismiss it first, then show the new one.
            visibleItem = nil
            Task {
                try? await Task.sleep(for: .seconds(0.8))
                visibleItem = presentation.item
            }
        }
    }

    private func dismiss() {
        dismissTask?.cancel()
        visibleItem = nil
        presentation.dismiss()
    }

    private func scheduleDismiss(after seconds: Double) {
        dismissTask?.cancel()
        dismissTask = Task {
            try? await Task.sleep(for: .seconds(seconds))
            if !Task.isCancelled { dismiss() }
        }
    }
}

// MARK: - Previews

#Preview {

    enum MyToast: String, Identifiable {
        case toast1
        case toast2
        case toast3

        var id: String { rawValue }

        @MainActor
        var message: ToastMessage {
            .init(messageResource)
        }

        var messageResource: LocalizedStringResource {
            switch self {
            case .toast1: "Hello from the top!"
            case .toast2: "Hello again from the top!"
            case .toast3: "Hello from the bottom!"
            }
        }
    }

    struct MyView: View {

        @State var topToast = Presentation<MyToast>()
        @State var bottomToast = Presentation<MyToast>()

        var body: some View {
            List {
                Button("Show top toast") {
                    topToast.present(.toast1)
                }
                Button("Show another top toast") {
                    topToast.present(.toast2)
                }
                Button("Show bottom toast") {
                    bottomToast.present(.toast3)
                }
            }
            .toast(for: $topToast) { item in
                item.message
            }
            .toast(for: $bottomToast, edge: .bottom) { item in
                item.message
                    .toastDuration(seconds: 5)
            }
        }
    }

    return MyView()
}
