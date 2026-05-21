# Sheets

Use the sheet modifiers to present sheets that animate size changes or fit their content.

## Overview

PresentationKit makes it easy to present sheets from a ``Presentation`` instance, and provides utilities to make sheets animate size changes and size to fit their content.


## Presentation

To present a sheet with a ``Presentation`` instance, just apply the ``SwiftUICore/View/sheet(for:onDismiss:content:)`` view modifier and return a content view for the presented item:

```swift
struct MyView: View {

    @State var sheet = Presentation<MyContent>()

    var body: some View {
        Button("Show sheet") {
            sheet.present(.someValue)
        }
        .sheet(for: $sheet) { content in
            MySheetView(content: content)
        }
    }
}
```

## Animated Size Changes

Use the ``SwiftUICore/View/presentationDetents(animated:manual:)`` modifier to make a sheet animate when the animated detent changes:

```swift
struct MyView: View {

    @State var isPresented = true
    @State var sheetSize: AnimatedPresentationDetent = .sizeToFit

    var body: some View {
        VStack {
            Button("Present Sheet") {
                isPresented.toggle()
            }
            Button("Animate Size Change") {
                sheetSize = .height(300)
            }
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
```

## Size to Fit

Use the ``SwiftUICore/View/presentationDetents(_:additional:)`` modifier to make a sheet fit its content, with optional additional drag detents:

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
```

> Note: This modifier uses standard system detents under the hood, which means size changes are not animated. Use ``SwiftUICore/View/presentationDetents(animated:manual:)`` if your sheet changes size.

## Topics

- ``AnimatedPresentationDetent``
- ``SizeToFitPresentationDetent``
