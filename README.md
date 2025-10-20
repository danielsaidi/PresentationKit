<p align="center">
    <img src="Resources/Icon-Badge.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/PresentationKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-6.1-orange.svg" alt="Swift 6.1" />
    <a href="https://danielsaidi.github.io/PresentationKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/PresentationKit/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/PresentationKit" alt="MIT License" /></a>
    <a href="https://github.com/sponsors/danielsaidi"><img src="https://img.shields.io/badge/sponsor-GitHub-red.svg" alt="Sponsor my work" /></a>
</p>


# PresentationKit

PresentationKit is a SwiftUI library that makes it easy to present alerts, sheets, and full screen covers for any type, using observable ``AlertContext``, ``FullScreenCoverContext``, and ``SheetContext`` classes.

<p align="center">
    <img src="https://github.com/danielsaidi/PresentationKit/releases/download/0.1.0/PresentationKit-Demo.gif" alt="Demo Gif" width="300" />
</p>

PresentationKit lets you register a presentation for any identifiable model, and will create and inject unique context values for each modal layer. This lets you use the current contexts to present new content from any view.



## Installation

PresentationKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PresentationKit.git
```



## Supported Platforms

PresentationKit supports iOS 17, tvOS 17, macOS 14, watchOS 10, and visionOS 1.



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting Started

PresentationKit makes it easy to present alerts, full screen covers, and sheets, using observable contexts with any kind of models that we want to present.

All we have to do to be able to present a model from anywhere within our app, is to apply a ``presentation(...)`` view modifier to the application root:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .presentation(
                    for: MyModel.self,
                    alertContent: { value in
                        AlertContent(
                            title: "Alert",
                            actions: {
                                Button("OK", action: { print("OK for item #\(value.id)") })
                                Button("Cancel", role: .cancel, action: {})
                            },
                            message: { Text("Alert for item #\(value.id)") }
                        )
                    },
                    coverContent: { 
                        MyModelView(value: $0, title: "Cover") 
                    },
                    sheetContent: { 
                        MyModelView(value: $0, title: "Sheet")
                    }
                )
        }
    }
}
```

You can omit any builder that you're not going to use. For instance, you don't have to define an alert content if you don't intend to present your model in an alert.

This will inject presentation contexts into the environment, that we can use to present our model from anywhere:

```swift
struct ContentView: View {

    @Environment(AlertContext<Model>.self) private var alert
    @Environment(FullScreenCoverContext<Model>.self) private var cover
    @Environment(SheetContext<Model>.self) private var sheet

    private let value = Model(id: 1)

    var body: some View {
        NavigationStack {
            List {
                Button("Present an alert") {
                    alert.present(value)
                }
                Button("Present a full screen cover") {
                    cover.present(value)
                }
                Button("Present a sheet") {
                    sheet.present(value)
                }
            }
            .navigationTitle("Demo")
        }
    }
}
```

PresentationKit will create and inject new contexts as we present modals. This means that we only have to add our presentation strategy *once*, except whein applying multiple presentations. See [getting-started][Getting-Started] for more info.

PresentationKit also has an ``ErrorAlerter`` protocol that makes it easy to automatically present error alerts, and a ``NavigationContext`` that can be used to observe a navigation path. 

For more information regarding more complex presentation strategies and functionality not covered by this guide, please see the [getting-started guide][Getting-Started].



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has a demo app that lets you explore the library.



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
