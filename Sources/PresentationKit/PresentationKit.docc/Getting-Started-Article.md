#  Getting Started

This article describes how to get started with PresentationKit.

PresentationKit makes it easy to present alerts, full screen covers, and sheets, using the observable ``AlertContext``, ``FullScreenCoverContext``, and ``SheetContext`` types together with any kind of model that we want to present.

All we have to do to be able to present a model in an alert or a modal, from anywhere in our app, is to apply a ``SwiftUICore/View/presentation(for:alertContent:fullScreenCoverContent:sheetContent:)`` view modifier to the application root:

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

This will ensure that the registered model is presented in the way we specify. You can omit any builder that you're not going to use. For instance, you don't have to provide an alert content builder if you don't intend to present your model in an alert.

The presentation will inject observable presentation contexts into the environment. We can use these contexts to present model values from anywhere within our app:

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

PresentationKit will create and inject new contexts when we present modals. This means that we only have to specify our presentation strategy *once*, after which the same presentations will work in the entire app.



## Going Further

### Multiple Presentation Modifiers

PresentationKit supports registering different presentation strategies for different models, which means that we can chain presentation strategies together to support multiple model and error types. 

However, since each presentation modifier will only create and inject new contexts for its specific model, we must apply the same multi-presentation strategy for every new modal that we create, otherwise new modals will lack injected environment values.

See the demo app for examples on how you can apply the same presentation modifier to both the app root view and its modal screens. 



### Multi-Window Apps & Focus Values

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


### Automatic Error Alerting for Failing Operations

PresentationKit has an ``ErrorAlerter`` protocol that makes it easy to automatically present error alerts, for instance when a SwiftUI triggers an asynchronous operation that fails.

To use the ``ErrorAlerter`` protocol, just let your view or model implement it, then use any ``ErrorAlerter/tryWithErrorAlert(_:)`` function to trigger an asynchronous operation that will automatically alert any errors that are thrown.


### Navigation Utilities

PresentationKit has a ``NavigationContext`` that can be used to observe a navigation path, as well as a ``NavigationButton`` that can be used to trigger a navigation with a button instead of a NavigationLink.
