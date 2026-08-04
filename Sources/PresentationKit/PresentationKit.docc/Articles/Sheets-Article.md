# Sheets

PresentationKit can present value-based sheets and animate size changes.

To present a ``Presentation``-based sheet, apply the ``SwiftUICore/View/sheet(for:onDismiss:content:)`` modifier and return a content view for the presented value:

```swift
enum AppSheet: String, Identifiable {
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

    @State var sheet = Presentation<AppSheet>()

    var body: some View {
        Button("Show Sheet") {
            sheet.present(.red)
        }
        .sheet(for: $sheet) { sheet in
            sheet.content
                .ignoresSafeArea()
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
