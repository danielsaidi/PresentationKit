#  Getting Started

This article describes how to get started with PresentationKit.

PresentationKit makes it easy to present any type in alerts, full screen covers and sheets, using the observable ``AlertContext``, ``FullScreenCoverContext``, and ``SheetContext`` classes.

All we have to do to be able to present a type, is to apply a presentation modifier to the application root for the type we want to present:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .presentation(
                    for: MyModel.self,
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
                        MyModelView(value: $0, title: "Cover") 
                    },
                    sheetContent: { 
                        MyModelView(value: $0, title: "Sheet")
                    }
                )
        }
    }
}
```

You can omit any builder that you're not going to use. For instance, you don't have to provide an alert content if you won't alert the type.

The presentation will inject presentation contexts into the environment, which we can use to present values from anywhere in the app:

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

PresentationKit will create and inject new contexts for new modals. This means that we only have to specify our presentation strategy *once*, after which the same presentations will work in the entire app.

> Important: When using multiple presentation modifiers, we must apply the presentation strategy to our modals as well, since we will otherwise not get all the contexts injected. See the demo for an example on how we can do this automatically. 



## Going Further

### Legacy Presentation Contexts

PresentationKit has ``AnyPresentationContext`` types that are kept for legacy purposes. Thes contexts make it possible to present alerts and views via injected contexts. This is a lot more flexible, but doesn't use the item presentation approach of modern SwiftUI.

You can use the ``AnyAlertContext``, ``AnyFullScreenCoverContext``, and ``AnySheetContext`` and their related view modifiers, but this part of the library may be removed in a future update.


### Multi-Window Apps & Focus Values

Multi-windowed apps must be able to keep track of the contexts that belong to the current window, so that the correct values are used.

While the ``AnyPresentationContext`` contexts have focused values, you must create specific focused values for the generic ones:

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


### Automatic Error Alerting for Failing Operations

PresentationKit has an ``ErrorAlerter`` protocol that makes it easy to automatically present error alerts, for instance when a SwiftUI triggers an asynchronous operation that fails.

To use the ``ErrorAlerter`` protocol, just let your view or model implement it, then use any ``ErrorAlerter/tryWithErrorAlert(_:)`` function to trigger an asynchronous operation that will automatically alert any errors that are thrown.


### Navigation Utilities

PresentationKit has a ``NavigationContext`` that can be used to observe a navigation path, as well as a ``NavigationButton`` that can be used to trigger a navigation with a button instead of a NavigationLink.
