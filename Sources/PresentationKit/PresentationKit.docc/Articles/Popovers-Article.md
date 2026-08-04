# Popovers

PresentationKit can present value-based popovers.

To present a ``Presentation``-based popover, apply the ``SwiftUICore/View/popover(for:attachmentAnchor:arrowEdge:content:)`` modifier and return a content view for the presented value:

```swift
enum AppPopover: String, Identifiable {
    case red, green, blue

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .red: .red
        case .green: .green
        case .blue: .blue
        }
    }

    var content: some View {
        color
            .cornerRadius(20)
            .padding()
            .frame(idealWidth: 320, idealHeight: 240)
    }
}

struct MyView: View {

    @State var popover = Presentation<AppPopover>()

    var body: some View {
        Button("Show Popover") {
            popover.present(.red)
        }
        .popover(for: $popover) { popover in
            popover.content
        }
    }
}

return MyView()
```

The modifier will automatically apply a presentation popover adaptation to the content view, so you don't have to.

> Important: Popovers are not available on tvOS and watchOS.


## Topics

### Extensions

- ``SwiftUICore/View``

