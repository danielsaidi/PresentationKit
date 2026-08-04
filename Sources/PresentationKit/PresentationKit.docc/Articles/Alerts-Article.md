# Alerts

PresentationKit can present value-based alerts and automatically handle errors.

To present a ``Presentation``-based alert, apply the ``SwiftUICore/View/alert(for:content:)`` modifier and return an ``AlertMessage`` for the item:

```swift
enum AppAlert: String, Identifiable {
    case somethingHappened

    var id: String { rawValue }

    var message: AlertMessage {
        switch self {
        case .somethingHappened:
            AlertMessage(
                title: "Hello",
                message: { Text("Something happened.") },
                actions: { Button("OK", action: {}) }
            )
        }
    }
}

struct MyView: View {

    @State var alert = Presentation<AppAlert>()

    var body: some View {
        Button("Show alert") {
            alert.present(.somethingHappened)
        }
        .alert(for: $alert) { alert in
            alert.message
        }
    }
}
```

## Error Alerts

Any type that implements ``ErrorAlerter`` can perform throwing async operations with automatic error alerts. If the error conforms to the ``AlertableError`` protocol, the ``SwiftUICore/View/alert(for:content:)`` modifier will automatically map it to an ``AlertMessage``.

```swift
enum AppError: String, AlertableError {
    case minor, major

    var id: String { rawValue }

    var alertMessage: AlertMessage {
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
                    try await simulateOperation(error: AppError.minor)
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
