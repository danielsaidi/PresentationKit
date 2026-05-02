//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            Preview()
                .navigationTitle("PresentationKit")
        }
    }
}

struct Preview: View {

    @State var isPresented = true

    @State var detent: AnimatedPresentationDetent = .sizeToFit

    var body: some View {
        Button("Present Sheet") {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            PreviewSheet(
                detent: $detent
            )
            .presentationDetents(
                animated: detent,
                standard: [.medium]
            )
        }
    }
}

struct PreviewSheet: View {

    @Binding var detent: AnimatedPresentationDetent

    @State var isTextContentExpanded = true
    @State var isThumbsSectionExpanded = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Title")
                .font(.title.bold())

            Button("Toggle Detent") {
                detent = detent == .sizeToFit ? .fraction(0.5) : .sizeToFit
            }

            if isThumbsSectionExpanded {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(height: 200)
            }

            Button("Expand") {
                isThumbsSectionExpanded.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
