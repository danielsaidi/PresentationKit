# Full Screen Covers

Use the full screen cover modifier to present full screen covers.

## Overview

PresentationKit makes it easy to present full screen covers from a ``Presentation`` instance.


## Presentation

To present a full screen cover with a ``Presentation`` instance, just apply the ``SwiftUICore/View/fullScreenCover(for:onDismiss:content:)`` view modifier and return a content view for the presented item:

```swift
struct MyView: View {

    @State var cover = Presentation<MyContent>()

    var body: some View {
        Button("Show cover") {
            cover.present(.someValue)
        }
        #if !os(macOS)
        .fullScreenCover(for: $cover) { content in
            MyCoverView(content: content)
        }
        #endif
    }
}
```

> Note: Full screen covers are not available on macOS.

## Topics

### Extensions

- ``SwiftUICore/View``

