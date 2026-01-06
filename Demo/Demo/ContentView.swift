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
            DemoActions()
                .navigationTitle("Title.Demo")
        }
    }
}

#Preview {
    DemoPreview {
        ContentView()
    }
}
