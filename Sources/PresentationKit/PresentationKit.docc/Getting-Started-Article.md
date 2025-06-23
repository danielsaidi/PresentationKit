#  Getting Started

This article describes how to get started with PresentationKit.

To use PresentationKit, just apply any of the available `.presentation(for: ...)` view modifiers to your application root, then use the environment injected ``AlertContext``, ``FullScreenCoverContext``, and ``SheetContext`` to present alerts and modals.

For instance, consider that we have the following, super-simple type, which in a real world app could be a complex model, an error type, a screen-defining enum, or any type that you want to present:

```swift
struct Model: Identifiable {

    let id: Int
}
```

All we have to do to be able to present this type in an alert, full screen cover, or sheet is to define a presentation strategy for it like this:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
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
                    coverContent: { 
                        ModalView(value: $0, title: "Cover") 
                    },
                    sheetContent: { 
                        ModalView(value: $0, title: "Sheet")
                    }
                )
        }
    }
}
```

You can omit any builder that you're not going to use. To only alert errors, you only have to provide an alert content builder, and to only present modals, you only have to provide a modal content builder.

The ContentView, and all views in its view hierarchy, can now present Model values with the various context ``PresentationContext/present(_:)`` functions:

```swift
struct ContentView: View {

    @Environment(AlertContext<Model>.self) private var alert
    @Environment(FullScreenCoverContext<Model>.self) private var cover
    @Environment(SheetContext<Model>.self) private var sheet

    private let value = Model(id: 1)

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
```

PresentationKit will apply the same presentation strategy to all modals, using new context values, which means that this will also work:

```swift
struct ModalView: View {

    let value: Model
    let title: String

    @Environment(\.dismiss) private var dismiss

    @Environment(AlertContext<Model>.self) private var alert
    @Environment(FullScreenCoverContext<Model>.self) private var cover
    @Environment(SheetContext<Model>.self) private var sheet

    private let value = Model(id: 2)

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
```

In other words, you only have to specify your presentation strategy *once*, after which the same presentations will work in the entire app.



## Going Further

### Supporting Multi-Window Apps

Multi-windowed apps must be able to keep track of the contexts that belong to the current window, so that the correct contexts can be used to present alerts and modals from global places, like commands and the menu bar.

To handle this with the generic context classes, you have to create type-specific focused values:

```swift
struct MyModel: Identifiable { ... }

extension FocusedValues {

    @Entry var myModelAlertContext: AlertContext<MyModel>?
    @Entry var myModelCoverContext: FullScreenCoverContext<MyModel>?
    @Entry var myModelSheetContext: SheetContext<MyModel>?
}
```

You can then register the currently focused context from your current window, using the `.focusedValue(...)` view modifier: 

```swift
struct ContentView: View {

    @Environment(\.myModelAlertContext) var alert
    @Environment(\.myModelCoverContext) var cover
    @Environment(\.myModelSheetContext) var sheet

    var body: some View {
        VStack {
            ...
        }
        .focusedValue(\.myModelAlertContext, alert)
        .focusedValue(\.myModelCoverContext, cover)
        .focusedValue(\.myModelSheetContext, sheet)
    }
}
```

You can then use `@FocusedValue` to access the currently focused values from a command or the main menu:

```swift
@FocusedValue(\.myModelAlertContext) var alert
@FocusedValue(\.myModelCoverContext) var cover
@FocusedValue(\.myModelSheetContext) var sheet
```

By using typed focus values, you can inject as many contexts as you like and use each value to access the correct context.


### Automated Error Alerts

PresentationKit has an ``ErrorAlerter`` protocol that makes it easy to automatically present error alerts, for instance when a SwiftUI triggers an asynchronous operation that fails.

To use the ``ErrorAlerter`` protocol, just let your view or model implement it, then use any ``ErrorAlerter/tryWithErrorAlert(_:)`` function to trigger an asynchronous operation that will automatically alert any errors that are thrown.


### Navigation Utilities

PresentationKit has a ``NavigationContext`` that can be used to observe a navigation path, as well as a ``NavigationButton`` that can be used to trigger a navigation with a button instead of a NavigationLink.
