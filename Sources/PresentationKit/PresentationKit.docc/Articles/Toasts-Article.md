# Toasts

Use the toast modifier to present toasts that slide in from a screen edge.

## Overview

PresentationKit makes it easy to present toasts from a ``Presentation`` instance, by sliding in from a screen edge and automatically dismissing after a certain time, or when the user swipes it.


## Presentation

To present a toast with a ``Presentation`` instance, just apply the ``SwiftUICore/View/toast(for:edge:content:)`` view modifier and return a view for the presented item:

```swift
struct MyView: View {

    @State var toast = Presentation<MyToast>()

    var body: some View {
        Button("Show toast") {
            toast.present(.init(message: "Hello!"))
        }
        .toast(for: $toast) { item in
            ToastMessage(item.message)
                .padding()
        }
    }
}
```


## Presentation Edge

Toasts slide in from the ``ToastPresentationEdge/top`` edge by default. Use the `edge` parameter to slide it in from another edge:

```swift
.toast(for: $toast, edge: .bottom) { item in
    ToastMessage(item.message)
        .padding()
}
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
