# Full Screen Covers

PresentationKit can present value-based full screen covers.

To present a ``Presentation``-based full screen cover, apply the ``SwiftUICore/View/fullScreenCover(for:onDismiss:content:)`` modifier and return a content view for the presented value:

```swift
enum AppCover: String, Identifiable {

    case red, green, blue

    var id: String { rawValue }

    var content: some View {
        switch self {
        case .red: Color.red
        case .green: Color.green
        case .blue: Color.blue
        }
    }
}

struct MyView: View {

    @State var cover = Presentation<AppCover>()

    var body: some View {
        Button("Show Cover") {
            cover.present(.red)
        }
        .fullScreenCover(for: $cover) { cover in
            cover.content
                .ignoresSafeArea()
        }
    }
}
```

> Important: Full screen covers are not available on macOS.


## Topics

### Extensions

- ``SwiftUICore/View``

