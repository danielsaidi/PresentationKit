# Alerts

Use the alert modifiers to present alerts and automatically handle errors.

## Overview

PresentationKit makes it easy to present alerts from a ``Presentation`` instance, and to automatically alert any errors that are thrown during async operations.


## Presentation

Use the ``SwiftUICore/View/alert(for:content:)`` modifier with a ``Presentation`` instance, and return an ``AlertMessage`` for the item to present:

```swift
struct MyView: View {

    @State var alert = Presentation<MyContent>()

    var body: some View {
        Button("Show alert") {
            alert.present(.someValue)
        }
        .alert(for: $alert) { content in
            AlertMessage(title: content.id) {
                Button("OK") {}
            } message: {
                Text("Something happened.")
            }
        }
    }
}
```

## Error Alerts

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
            Button("Perform a failing operation") {
                tryWithErrorAlert {
                    try await simulateOperation(error: MyError.minor)
                }
            }
        }
        .alert(for: $alertError)
    }
}
```

## Topics

- ``AlertableError``
- ``AlertMessage``
- ``ErrorAlerter``

### Extensions

- ``SwiftUICore/View``
