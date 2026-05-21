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
    @State private var duration: Double = 5

    func body(content: Content) -> some View {
        content.overlay(alignment: edge.alignment) {
            if let item = visibleItem {
                self.content(item)
                    .transition(.move(edge: edge.swiftUIEdge).combined(with: .opacity))
                    .onTapGesture { dismiss() }
                    .gesture(edge.dismissSwipe { dismiss() })
                    .onPreferenceChange(ToastDurationKey.self) { duration = $0 ?? 5 }
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

    return MyView()

    struct MyToast: Identifiable {
        let id = UUID()
        let message: String
    }

    struct MyView: View {

        @State var topToast = Presentation<MyToast>()
        @State var bottomToast = Presentation<MyToast>()

        var body: some View {
            List {
                Button("Show top toast") {
                    topToast.present(.init(message: "Hello from the top!"))
                }
                Button("Show another top toast") {
                    topToast.present(.init(message: "Hello again from the top!"))
                }
                Button("Show bottom toast") {
                    bottomToast.present(.init(message: "Hello from the bottom!"))
                }
            }
            .toast(for: $topToast) { item in
                ToastMessage(item.message)
                    .padding()
            }
            .toast(for: $bottomToast, edge: .bottom) { item in
                ToastMessage(item.message)
                    .padding()
                    .toastDuration(seconds: 1.5)
            }
        }
    }
}
