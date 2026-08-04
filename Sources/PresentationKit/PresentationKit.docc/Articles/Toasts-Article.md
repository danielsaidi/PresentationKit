# Toasts

PresentationKit can present value-based toasts that slide in from a screen edge.

To present a ``Presentation``-based toast, apply the ``SwiftUICore/View/toast(for:edge:content:)`` modifier and return a content view for the presented value:

```swift
enum MyToast: String, Identifiable {
    case toast1
    case toast2
    case toast3

    var id: String { rawValue }

    @MainActor
    var message: ToastMessage {
        .init(messageResource)
    }

    var messageResource: LocalizedStringResource {
        switch self {
        case .toast1: "Hello from the top!"
        case .toast2: "Hello again from the top!"
        case .toast3: "Hello from the bottom!"
        }
    }
}

struct MyView: View {

    @State var topToast = Presentation<MyToast>()
    @State var bottomToast = Presentation<MyToast>()

    var body: some View {
        List {
            Button("Show top toast") {
                topToast.present(.toast1)
            }
            Button("Show another top toast") {
                topToast.present(.toast2)
            }
            Button("Show bottom toast") {
                bottomToast.present(.toast3)
            }
        }
        .toast(for: $topToast) { item in
            item.message
        }
        .toast(for: $bottomToast, edge: .bottom) { item in
            item.message
                .toastDuration(seconds: 5)
        }
    }
}
```


## Presentation Edge

Toasts slide in from the ``ToastPresentationEdge/top`` edge by default. Use the `edge` parameter to slide it in from another edge:

```swift
.toast(for: $toast, edge: .bottom) { ... }
```


## Duration

Toasts auto-dismiss after 3 seconds by default. Apply ``SwiftUICore/View/toastDuration(seconds:)`` to the content view to use a custom duration:

```swift
.toast(for: $toast) { item in
    ToastMessage(item.message)
        .padding()
        .toastDuration(seconds: 2)
}
```


## Dismissal

The user can dismiss a toast by swiping it toward the presentation edge.


## Toast Views

PresentationKit provides two ready-made toast views:

- ``Toast`` wraps any content in a capsule with a material background and a subtle shadow.
- ``ToastMessage`` wraps a text string in a ``Toast`` with standard padding.

Both can be customized with a ``ToastStyle``, which controls the background and shadow via ``ToastShadowStyle``.

```swift
.toast(for: $toast) { item in
    ToastMessage(item.message)
        .padding()
}
```


## Topics

- ``Toast``
- ``ToastMessage``
- ``ToastStyle``
- ``ToastShadowStyle``
- ``ToastPresentationEdge``
