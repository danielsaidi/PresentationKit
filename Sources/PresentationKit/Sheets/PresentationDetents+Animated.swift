//
//  AnimatedSheet.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-01.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to apply presentation detents that
/// animate when they are being changed with code.
///
/// You can apply animated and standard detents view the new
/// ``SwiftUICore/View/presentationDetents(animated:standard:)``
/// view modifier. The animated detent will automatically be
/// animated when changed, while the standard detents can be
/// used by the user to manually change the detents.
public enum AnimatedPresentationDetent: Sendable, Equatable {

    /// This detent makes the presentation fit the content.
    case sizeToFit

    /// This detent maps to a native `.height` detent.
    case height(Double)

    /// This detent maps to a native `.fraction` detent.
    case fraction(Double)
}

public extension AnimatedPresentationDetent {

    /// This is a fraction approximation of regular `.large`.
    static var large: Self { .fraction(0.95) }

    /// This is a fraction approximation of regular `.medium`.
    static var medium: Self { .fraction(0.5) }

    /// This is a fraction approximation of regular `.small`.
    static var small: Self { .fraction(0.25) }
}

public extension View {

    /// Sets the available detents for the enclosing sheet.
    func presentationDetents(
        animated detent: AnimatedPresentationDetent,
        manual: Set<PresentationDetent> = []
    ) -> some View {
        modifier(PresentationDetentsAnimatedModifier(
            detent: detent,
            manual: manual
        ))
    }
}

private extension AnimatedPresentationDetent {

    func nativeDetent(for contentHeight: Double) -> PresentationDetent {
        switch self {
        case .height(let value): .height(value)
        case .fraction(let value): .fraction(value)
        case .sizeToFit: .height(contentHeight)
        }
    }
}

private struct PresentationDetentsAnimatedModifier: ViewModifier {
    let detent: AnimatedPresentationDetent
    let manual: Set<PresentationDetent>

    @State private var contentHeight = 0.0
    @State private var selectedDetent = PresentationDetent.height(0)
    @State private var availableDetents = Set<PresentationDetent>()

    func body(content: Content) -> some View {
        let effectiveDetent = detent.nativeDetent(for: contentHeight)
        let shouldUseSelection = detent != .sizeToFit || contentHeight > 0

        content
            .onGeometryChange(for: CGFloat.self) {
                $0.size.height
            } action: { height in
                contentHeight = height
                updateDetents(for: detent)
            }
            .onAppear {
                selectedDetent = effectiveDetent
                availableDetents = Set([effectiveDetent] + manual)
            }
            .onChange(of: detent) { _, newValue in
                updateDetents(for: newValue)
            }
            .modifier(PresentationDetentsSelectionModifier(
                shouldUseSelection: shouldUseSelection,
                detents: shouldUseSelection ? availableDetents.union([selectedDetent]) : Set([effectiveDetent] + manual),
                selection: Binding(
                    get: { selectedDetent },
                    set: { selectedDetent = $0 }
                )
            ))
    }

    private func updateDetents(for detent: AnimatedPresentationDetent) {
        let newDetent = detent.nativeDetent(for: contentHeight)
        availableDetents = Set([selectedDetent, newDetent] + manual)
        withAnimation(.bouncy) {
            selectedDetent = newDetent
        }
    }
}

private struct PresentationDetentsSelectionModifier: ViewModifier {
    let shouldUseSelection: Bool
    let detents: Set<PresentationDetent>
    @Binding var selection: PresentationDetent

    @ViewBuilder
    func body(content: Content) -> some View {
        if shouldUseSelection {
            content.presentationDetents(detents, selection: $selection)
        } else {
            content.presentationDetents(detents)
        }
    }
}

#Preview {

    return MyView()

    struct MyView: View {

        @State var isPresented = true
        @State var size: AnimatedPresentationDetent = .sizeToFit

        var body: some View {
            Button("Present Sheet") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                MySheet(size: $size)
                    .presentationDetents(
                        animated: size,
                        manual: [.medium, .large]
                    )
            }
        }
    }

    struct MySheet: View {

        @Binding var size: AnimatedPresentationDetent

        @State var isExpanded = false

        var body: some View {
            VStack(spacing: 16) {
                Text("Sheet Title")
                    .font(.title.bold())

                Text("Sheet Text")

                if isExpanded {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(height: 200)
                }

                HStack {
                    Button("Toggle Size") {
                        size = size == .sizeToFit ? .fraction(0.5) : .sizeToFit
                    }
                    Button("Toggle Content") {
                        isExpanded.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
