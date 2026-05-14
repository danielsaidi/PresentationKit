//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

struct ContentView: View, ErrorAlerter {

    @State var alertContext = PresentationContext<DemoContent>()
    @State var coverContext = PresentationContext<DemoContent>()
    @State var sheetContext = PresentationContext<DemoContent>()

    @State var errorContext = PresentationContext<Error>()

    @State var animatedSheetSize = AnimatedPresentationDetent.sizeToFit
    @State var isAnimatedSheetPresented = false
    @State var isSizeToFitSheetPresented = false

    var body: some View {
        NavigationStack {
            List {
                Section("Presentation Context") {
                    Button("Present Red Alert") {
                        alertContext.present(.red)
                    }
                    Button("Present Green Cover") {
                        coverContext.present(.green)
                    }
                    Button("Present Blue Sheet") {
                        sheetContext.present(.blue)
                    }
                }

                Section("Error Alerter") {
                    Button("Perform a successful operation") {
                        tryWithErrorAlert {
                            try await simulateAsyncOperation(error: nil)
                        }
                    }
                    Button("Perform a minor failing operation") {
                        tryWithErrorAlert {
                            try await simulateAsyncOperation(error: .minor)
                        }
                    }
                    Button("Perform a major failing operation") {
                        tryWithErrorAlert {
                            try await simulateAsyncOperation(error: .major)
                        }
                    }
                }

                Section("Sheets") {
                    Button("Present Animated Sheet") {
                        isAnimatedSheetPresented.toggle()
                    }
                    Button("Present Size-To-Fit Sheet") {
                        isSizeToFitSheetPresented.toggle()
                    }
                }
            }
            .navigationTitle("PresentationKit")
            .alert(for: $alertContext) { content in
                AlertMessage(title: content.id)
            }
            .alert(for: $errorContext)
            #if !os(macOS)
            .fullScreenCover(for: $coverContext) { content in
                DemoContentCover(content: content)
            }
            #endif
            .sheet(for: $sheetContext) { content in
                DemoContentSheet(content: content)
            }
            .sheet(isPresented: $isAnimatedSheetPresented) {
                DemoSheetAnimated(size: $animatedSheetSize)
                    .presentationDetents(
                        animated: animatedSheetSize,
                        manual: [.medium, .large]
                    )
            }
            .sheet(isPresented: $isSizeToFitSheetPresented) {
                DemoSheetSizeToFit()
                    .presentationDetents(
                        .sizeToFit,
                        additional: [.medium, .large]
                    )
            }
        }
    }
}

private extension ContentView {

    func simulateAsyncOperation(error: DemoError?) async throws {
        if let error { throw error }
    }
}

enum DemoContent: String, Identifiable, View {
    case red, green, blue

    var id: String { rawValue.capitalized }

    var body: some View {
        switch self {
        case .red: Color.red
        case .green: Color.green
        case .blue: Color.blue
        }
    }
}

struct DemoContentCover: View {
    let content: DemoContent

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            content
                .ignoresSafeArea()
                .toolbar {
                    Button("Close", action: dismiss.callAsFunction)
                }
        }
    }
}

struct DemoContentSheet: View {
    let content: DemoContent

    var body: some View {
        content
            .ignoresSafeArea()
    }
}

enum DemoError: String, AlertableError {
    case minor, major

    var id: String { rawValue }

    var alertMessage: AlertMessage<AnyView, AnyView> {
        AlertMessage(
            title: "A \(rawValue) error occured",
            message: { Text("Please try again.") },
            actions: { Button("OK", action: {}) }
        )
    }
}

struct DemoSheetAnimated: View {

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

struct DemoSheetSizeToFit: View {

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

#Preview {
    ContentView()
}
