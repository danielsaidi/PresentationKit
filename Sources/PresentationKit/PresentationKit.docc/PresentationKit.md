# ``PresentationKit``

A SwiftUI library that makes it easy to present and navigate to items.

## Overview

![Library logotype](Logo.png)

PresentationKit is a SwiftUI library that makes it easy to perform value-based ``Navigation`` and value-based alert, sheet, and modal ``Presentation``. The library also has additional utilities for alerts, errors, navigation, sheets, and toasts.



## Installation

PresentationKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PresentationKit.git
```



## Supported Platforms

PresentationKit supports iOS 17, tvOS 17, macOS 14, watchOS 10, and visionOS 1.



## Getting Started

The documentation has separate articles for each feature in the library. 

### Navigation

The ``Navigation`` class makes it easy to perform value-based navigation with a navigation stack.

See the <doc:Navigation-Article> article for more information.


### Presentation

The ``Presentation`` class makes it easy to perform value-based presentations and dismissals. It's the foundation to presenting <doc:Alerts-Article>, <doc:Full-Screen-Covers-Article>, <doc:Sheets-Article>, and <doc:Toasts-Article> .

See the <doc:Presentation-Article> article for more information.


### Alerts

PresentationKit makes it easy to present alerts and automatically handle errors thrown during async operations.

See the <doc:Alerts-Article> article for more information.


### Sheets

PresentationKit makes it easy to present sheets, with additional utilities for animated size changes and size-to-fit behavior.

See the <doc:Sheets-Article> article for more information.


### Full Screen Covers

PresentationKit makes it easy to present full screen covers on all non-macOS platforms.

See the <doc:Full-Screen-Covers-Article> article for more information.


### Toasts

PresentationKit makes it easy to present toasts that slide in from a screen edge and auto-dismiss after a configurable duration.

See the <doc:Toasts-Article> article for more information.




## Demo Application

The [project repository][Project] has a demo app that lets you explore the library.



## Repository

For more information, source code, etc., visit the [project repository][Project].



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## License

PresentationKit is available under the MIT license.



## Topics

### Articles

- <doc:Getting-Started-Article>
- <doc:Presentation-Article>
- <doc:Navigation-Article>
- <doc:Alerts-Article>
- <doc:Sheets-Article>
- <doc:Full-Screen-Covers-Article>
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
