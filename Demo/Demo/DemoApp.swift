//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

@main
struct DemoApp: App {

    @FocusedValue(\.demoModelAlertContext) var menuAlert
    @FocusedValue(\.demoModelCoverContext) var menuCover
    @FocusedValue(\.demoModelSheetContext) var menuSheet

    var body: some Scene {
        WindowGroup {
            ContentView()
                .withDemoPresentation()
        }
        .commands {
            CommandMenu("Menu.Demo") {
                DemoPresentationActions(
                    alert: menuAlert,
                    cover: menuCover,
                    sheet: menuSheet
                )
            }
        }
    }
}
