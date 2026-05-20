//
//  PresentationDetents+SizeToFit.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2026-05-14.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Sets the sheet detent to fit its content height.
    func presentationDetents(
        _ detent: SizeToFitPresentationDetent,
        additional: Set<PresentationDetent> = []
    ) -> some View {
        modifier(SizeToFitModifier(additional: additional))
    }
}

/// This detent type causes a sheet to fit its content.
public enum SizeToFitPresentationDetent {
    
    case sizeToFit
}

/// This private view modifier takes care of the size to fit.
private struct SizeToFitModifier: ViewModifier {
    let additional: Set<PresentationDetent>

    @State private var contentHeight = 0.0

    func body(content: Content) -> some View {
        let heightDetent = PresentationDetent.height(contentHeight)
        content
            .onGeometryChange(for: CGFloat.self) {
                $0.size.height
            } action: { height in
                contentHeight = height
            }
            .presentationDetents(Set([heightDetent]).union(additional))
    }
}

#Preview {

    return MyView()

    struct MyView: View {

        @State var isPresented = true

        var body: some View {
            Button("Present Sheet") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                MySheet()
                    .presentationDetents(
                        .sizeToFit,
                        additional: [.medium, .large]
                    )
            }
        }
    }

    struct MySheet: View {

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

                Button("Toggle Content") {
                    isExpanded.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
