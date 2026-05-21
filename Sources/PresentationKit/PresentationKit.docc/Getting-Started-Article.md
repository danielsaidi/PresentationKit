#  Getting Started

This article describes how to get started with PresentationKit.

PresentationKit makes it easy to perform value-based ``Navigation`` and value-based alert, sheet, and modal ``Presentation``. The library also has additional utilities for alerts, errors, navigation, and sheets.


## Navigation

The observable ``Navigation`` class makes it easy to perform value-based navigation. The ``Navigation/path`` can be bound to a navigation stack, and used to push and pop content to the stack.



## Presentation

The observable ``Presentation`` class makes it easy to present alerts, sheets, and modals in a single way. It has a single ``Presentation/item`` that you can ``Presentation/present(_:)`` and ``Presentation/dismiss()``. 

To use it, just create an instance and bind it to any view with the ``SwiftUICore/View/alert(for:content:)``, ``SwiftUICore/View/sheet(for:onDismiss:content:)`` and ``SwiftUICore/View/fullScreenCover(for:onDismiss:content:)`` view modifiers, then call ``Presentation/present(_:)`` to automatically present an item.

```swift
enum MyContent: String, @MainActor Identifiable, View {
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

struct MyView: View {

    @State var alert = Presentation<MyContent>()
    @State var cover = Presentation<MyContent>()
    @State var sheet = Presentation<MyContent>()

    var body: some View {
        List {
            Button("Present Red Alert") {
                alert.present(.red)
            }
            Button("Present Green Cover") {
                cover.present(.green)
            }
            Button("Present Blue Sheet") {
                sheet.present(.blue)
            }
        }
        .alert(for: $alert) { content in
            AlertMessage(title: content.id)
        }
        #if !os(macOS)
        .fullScreenCover(for: $cover) { content in
            content
        }
        #endif
        .sheet(for: $sheet) { content in
            content
        }
    }
}
```

As you can see above, the alert modifier must return an ``AlertMessage`` while the cover and sheet modifiers can return regular views. 


## Alerts

PresentationKit makes it easy to perform async throwing operations, and automatically alert any errors that are thrown during execution.

Any type that implements ``ErrorAlerter`` can perform throwing async operations with automatic error alerts. If an error conforms to the ``AlertableError`` protocol, the ``SwiftUICore/View/alert(for:)`` modifier will automatically map it to an ``AlertMessage``.

```swift
enum MyError: String, AlertableError {
    case minor, major

    var id: String { rawValue }

    var alertMessage: AlertMessage<AnyView, AnyView> {
        AlertMessage(
            title: "A \(rawValue) error occured",
            message: { Text("Please try again") },
            actions: { Button("OK", action: {}) }
        )
    }
}

struct MyView: View, @MainActor ErrorAlerter {

    @State var alertError = Presentation<Error>()

    func simulateOperation(error: Error?) async throws {
        if let error { throw error }
    }

    var body: some View {
        List {
            Button("Perform a successful operation") {
                tryWithErrorAlert {
                    try await simulateOperation(error: nil)
                }
            }
            Button("Perform a minor failing operation") {
                tryWithErrorAlert {
                    try await simulateOperation(error: MyError.minor)
                }
            }
            Button("Perform a major failing operation") {
                tryWithErrorAlert {
                    try await simulateOperation(error: MyError.major)
                }
            }
        }
        .alert(for: $alertError)
    }
}
```

The alert modifier we use here doesn't need to define an alert content builder, since the error is automatically converted to a message.


## Sheets

PresentationKit makes it easy to present sheets that automatically animate any size changes, and that resize to fit their content views.

### Animated Size Changes

You can use the ``SwiftUICore/View/presentationDetents(animated:manual:)`` view modifier to make a sheet animate its size when the content size or the animated detent changes, with additional manual detents that the user can apply by dragging the sheet handle:

```swift
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
```

The ``AnimatedPresentationDetent`` enum has a ``AnimatedPresentationDetent/sizeToFit`` detent, as well as a ``AnimatedPresentationDetent/fraction(_:)`` and a ``AnimatedPresentationDetent/height(_:)`` variant, with ``AnimatedPresentationDetent/small``, ``AnimatedPresentationDetent/medium``, and ``AnimatedPresentationDetent/large`` values that approximate the system defaults. 


### Size to fit

You can use the ``SwiftUICore/View/presentationDetents(_:additional:)`` view modifier to make a sheet fit its content, with additional standard detents that the user can apply by dragging the sheet handle:

```swift
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
```

Note that this modifier uses standard system detents under the hood, which means that any size changes are not animated. Use this to present sheets that will not change size.
