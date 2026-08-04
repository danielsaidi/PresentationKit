<p align="center">
    <img src="Resources/Icon-Badge.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/PresentationKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-6.1-orange.svg" alt="Swift 6.1" />
    <a href="https://danielsaidi.github.io/PresentationKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/PresentationKit/blob/main/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/PresentationKit" alt="MIT License" /></a>
</p>


# PresentationKit

PresentationKit is a SwiftUI library that makes it easy to present alerts, sheets, full screen covers, and toasts for any model, using an observable `Presentation` class.

<p align="center">
    <img src="https://github.com/danielsaidi/PresentationKit/releases/download/1.0.0/Demo.gif" alt="Demo Gif" width=1500 />
</p>



## Installation

PresentationKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PresentationKit.git
```



## Supported Platforms

PresentationKit supports iOS 17, tvOS 17, macOS 14, watchOS 10, and visionOS 1.



## Getting Started

PresentationKit has features for value-based navigation and presentation, and lets you present alerts, covers, popovers, sheets, and toasts in the same way. See the [documentation][Documentation] for more information.


### Navigation

The ``Navigation`` class can be used to perform value-based navigation.

```swift
struct MyView: View {

    @State var navigation = Navigation()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            Button("Push view") {
                navigation.push("detail")
            }
            .navigationDestination(for: String.self) { value in
                Text(value)
            }
        }
    }
}
```

Types that implement the ``NavigationDestination`` protocol can be used to create a `NavigationStack` for that specific type. 

See the [Navigation article][Navigation] for more information.


### Presentation

The ``Presentation`` class can be used to perform value-based presentation of alerts, modals, sheets, popovers, and toasts.

```swift
struct MyView: View {

    // In this example, consider there are enums for the various content types. 
    
    @State var alert = Presentation<MyAlert>()
    @State var cover = Presentation<MyModal>()
    @State var popover = Presentation<MyPopover>()
    @State var sheet = Presentation<MyModal>()
    @State var toast = Presentation<MyToast>()
    
    var body: some View {
        Button("Perform presentation") {
            alert.present(.someAlert)       // or
            cover.present(.someModal)       // or
            popover.present(.somePopover)   // or
            sheet.present(.someModal)       // or
            sheet.present(.someToast)
        }
        .alert(for: $alert) { alert in
            // Present an AlertMessage for the alert
        }
        #if !os(macOS)
        .fullScreenCover(for: $cover) { cover in
            // Present a view for the full screen cover
        }
        #endif
        .popover(for: $popover) { popover in
            // Present a view for the popover
        }
        .sheet(for: $sheet) { sheet in
            // Present a view for the sheet
        }
        .toast(for: $toast) { toast in
            // Present a view for the toast
        }
    }
}
```

Each modifier supports the same customizations as the native modifiers. For instance, sheets can define a dismiss action, popovers can define an arrow direction, toasts can define an edge, etc. 

PresentationKit also adds additional support to each content type. For instance, alerts can be used to automatically alert async errors, a sheets can be resized with animations, etc.

See the [Presentation article][Presentation] and the separate content type articles for more information.



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
[License]: https://github.com/danielsaidi/presentationkit/blob/master/LICENSE

[Navigation]: https://danielsaidi.github.io/PresentationKit/documentation/presentationkit/navigation-article
[Presentation]: https://danielsaidi.github.io/PresentationKit/documentation/presentationkit/presentation-article
