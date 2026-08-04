# ``PresentationKit``

A SwiftUI library that makes it easy to present and navigate to items.

## Overview

![Library logotype](Logo.png)

PresentationKit can perform value-based ``Navigation`` and value ``Presentation`` of alerts, sheets, modals, popovers, and toasts.



## Installation

PresentationKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PresentationKit.git
```



## Supported Platforms

PresentationKit supports iOS 17, tvOS 17, macOS 14, watchOS 10, and visionOS 1.



## Getting Started

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

See the <doc:Navigation-Article> article for more information.


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

See the <doc:Presentation-Article> article and the separate <doc:Alerts-Article>, <doc:Full-Screen-Covers-Article>, <doc:Popovers-Article>, <doc:Sheets-Article>, and <doc:Toasts-Article> articles for more information.




## Demo Application

The [project repository][Project] has a demo app that lets you explore the library.



## Repository

For more information, source code, etc., visit the [project repository][Project].



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## License

PresentationKit is available under the MIT license.



## Topics

### Getting Started

- <doc:Presentation-Article>
- <doc:Navigation-Article>

### Content Articles

- <doc:Alerts-Article>
- <doc:Full-Screen-Covers-Article>
- <doc:Popovers-Article>
- <doc:Sheets-Article>
- <doc:Toasts-Article>

### Essentials

- ``Navigation``
- ``Presentation``

### Alerts

- ``AlertableError``
- ``AlertMessage``
- ``ErrorAlerter``

### Navigation

- ``NavigationButton``
- ``NavigationChevron``
- ``NavigationChevronStyle``

### Sheets

- ``AnimatedPresentationDetent``
- ``SizeToFitPresentationDetent``

### Toasts

- ``Toast``
- ``ToastDuration``
- ``ToastMessage``
- ``ToastStyle``
- ``ToastShadowStyle``
- ``ToastPresentationEdge``

### Extensions

- ``SwiftUICore/View``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Project]: https://github.com/danielsaidi/PresentationKit
