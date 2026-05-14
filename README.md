<p align="center">
    <img src="Resources/Icon-Badge.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/PresentationKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-6.1-orange.svg" alt="Swift 6.1" />
    <a href="https://danielsaidi.github.io/PresentationKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/PresentationKit/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/PresentationKit" alt="MIT License" /></a>
</p>


# PresentationKit

PresentationKit is a SwiftUI library that makes it easy to present alerts, sheets, and full screen covers for any model, by using an observable ``PresentationContext``.

<p align="center">
    <img src="https://github.com/danielsaidi/PresentationKit/releases/download/0.1.0/PresentationKit-Demo.gif" alt="Demo Gif" width="300" />
</p>

PresentationKit also has utilities to manage alerts, errors, and navigation, and makes it easy to make a sheet size to fit its content, and to animate the sheet smoothly whenever its size changes. 



## Installation

PresentationKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PresentationKit.git
```



## Supported Platforms

PresentationKit supports iOS 17, tvOS 17, macOS 14, watchOS 10, and visionOS 1.



## Getting Started

Below are some common use-cases. For more information, see the [documentation][Documentation] and its [getting-started guide][Getting-Started].


### PresentationContext

The observable ``PresentationContext`` class makes it easy to present alerts, sheets, and modals in the same way.

To use it, just create a context instance and bind it to your view with the context-specific ``.alert(for:content:)``, ``.sheet(for:onDismiss:content:)`` and ``.fullScreenCover(for:onDismiss:content:)`` view modifiers.

```swift
enum MyContent: String, @MainActor Identifiable, View {
    case red, green, blue

    var id: String { rawValue.capitalized }

    var body: some View {
        switch self {
        case .red: Color.red
        case .green: Color.green
        case .blue: Color.blue
        }
    }
}

struct MyView: View {

    @State var alertContext = PresentationContext<MyContent>()
    @State var coverContext = PresentationContext<MyContent>()
    @State var sheetContext = PresentationContext<MyContent>()

    var body: some View {
        List {
            Button("Present Red Alert") {
                alertContext.present(.red)
            }
            Button("Present Green Cover") {
                coverContext.present(.green)
            }
            Button("Present Blue Sheet") {
                sheetContext.present(.blue)
            }
        }
        .alert(for: $alertContext) { content in
            AlertMessage(title: content.id)
        }
        #if !os(macOS)
        .fullScreenCover(for: $coverContext) { content in
            content
        }
        #endif
        .sheet(for: $sheetContext) { content in
            content
        }
    }
}
```

As you see above, the alert modifier returns an ``AlertMessage`` while the cover and sheet modifiers return views. 


### Alerts

Any type that implements ``ErrorAlerter`` can perform throwing async operations with automatic error alerts. If the error conforms to ``AlertableError``, the `.alert(for:)` will automatically map it to a message.

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

    @State var errorContext = PresentationContext<Error>()

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
            Button("Perform a minor failing operation") {
                tryWithErrorAlert {
                    try await simulateOperation(error: MyError.minor)
                }
            }
            Button("Perform a major failing operation") {
                tryWithErrorAlert {
                    try await simulateOperation(error: MyError.major)
                }
            }
        }
        .alert(for: $errorContext)
    }
}
```

As you can see above, the alert modifier we use here doesn't need to define an alert content builder, since the error will automatically be converted to a message.


### Sheets

PresentationKit makes it easy to present sheets that automatically animate any size changes, and that resize to fit their content views.

#### Animated Size Changes

You can use the ``.presentationDetents(animated:manual:)`` modifier to make a sheet animate its size changes, with additional manual detents that the user can apply by dragging the sheet handle:

```swift
struct MyView: View {

    @State var isPresented = true
    @State var size: AnimatedPresentationDetent = .sizeToFit

    var body: some View {
        Button("Present Sheet") {
            isPresented.toggle()
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

struct MySheet: View {

    @Binding var size: AnimatedPresentationDetent

    @State var isExpanded = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Sheet Title")
                .font(.title.bold())

            Text("Sheet Text")

            if isExpanded {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(height: 200)
            }

            HStack {
                Button("Toggle Size") {
                    size = size == .sizeToFit ? .fraction(0.5) : .sizeToFit
                }
                Button("Toggle Content") {
                    isExpanded.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
```

The ``AnimatedPresentationDetent`` enum has a ``.sizeToFit`` detent, as well as ``.fraction(_:)`` & ``.height(_:)`` variants, and ``.small``, ``.medium``, & ``.large`` values that approximate the system defaults. 


#### Size to fit

You can use the ``.presentationDetents(_:additional:)`` modifier to make a sheet fit its content, with additional standard detents that the user can apply by dragging the sheet handle:

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

struct MySheet: View {

    @State var isExpanded = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Sheet Title")
                .font(.title.bold())

            Text("Sheet Text")

            if isExpanded {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(height: 200)
            }

            Button("Toggle Content") {
                isExpanded.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
```

Note that this modifier uses standard system detents under the hood, which means that any size changes are not animated. Use this if you want to present a content view that will not change its size.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has a demo app that lets you explore the library.



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Contact

Feel free to reach out if you have questions, or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

PresentationKit is available under the MIT license. See the [LICENSE][License] file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Mastodon]: https://mastodon.social/@danielsaidi
[Twitter]: https://twitter.com/danielsaidi

[Documentation]: https://danielsaidi.github.io/PresentationKit
[Getting-Started]: https://danielsaidi.github.io/PresentationKit/documentation/presentationkit/getting-started
[License]: https://github.com/danielsaidi/presentationkit/blob/master/LICENSE
