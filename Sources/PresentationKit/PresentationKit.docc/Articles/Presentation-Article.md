# Presentation

The ``Presentation`` class can be used to present alerts, modals, popovers, sheets, and toasts.

## Overview

The observable ``Presentation`` class makes it easy to present alerts, sheets, modals, and toasts in a unified way. It has a single ``Presentation/item`` that you can ``Presentation/present(_:)`` and ``Presentation/dismiss()``.

To use it, create an instance and bind it to any view with a presentation-based modifier like ``SwiftUICore/View/sheet(for:onDismiss:content:)``, then call ``Presentation/present(_:)`` to present an item.

```swift
enum MyContent: String, @MainActor Identifiable, View {
    case red, green, blue

    var id: String { rawValue }

    var body: some View {
        switch self {
        case .red: Color.red
        case .green: Color.green
        case .blue: Color.blue
        case .yellow: Color.yellow
        case .black: Color.black
        }
    }
}

struct MyView: View {

    @State var alert = Presentation<MyContent>()
    @State var cover = Presentation<MyContent>()
    @State var popover = Presentation<MyContent>()
    @State var sheet = Presentation<MyContent>()
    @State var toast = Presentation<MyContent>()

    var body: some View {
        List {
            Button("Present Red Alert") {
                alert.present(.red)
            }
            Button("Present Green Cover") {
                cover.present(.green)
            }
            Button("Present Blue Popover") {
                popover.present(.blue)
            }
            Button("Present Yellow Sheet") {
                sheet.present(.yellow)
            }
            Button("Present Black Toast") {
                sheet.present(.black)
            }
        }
        .alert(for: $alert) { content in
            AlertMessage(title: content.capitalized)
        }
        #if !os(macOS)
        .fullScreenCover(for: $cover) { content in
            content
        }
        #endif
        .popover(for: $popover) { content in
            content
        }
        .sheet(for: $sheet) { content in
            content
        }
        .toast(for: $toast) { content in
            content
        }
    }
}
```


## Topics

- ``Presentation``

### Extensions

- ``SwiftUICore/View``
