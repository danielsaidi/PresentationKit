# ``PresentationKit``

A SwiftUI library that makes it easy to present alerts and modal content.

## Overview

![Library logotype](Logo.png)

PresentationKit is a SwiftUI library that makes it easy to present alerts, sheets, and full screen covers for any identifiable model, by using observable ``AlertContext``, ``FullScreenCoverContext``, and ``SheetContext`` classes.

PresentationKit lets you register a presentation strategy for any identifiable model, and will create and inject unique context values into the environment for each modal layer. This lets you use the current contexts to present new content from any view.



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

The <doc:Getting-Started-Article> article has information on how to get started with PresentationKit.



## Demo Application

The [project repository][Project] has a demo app that lets you explore the library.



## Repository

For more information, source code, etc., visit the [project repository][Project].



## License

PresentationKit is available under the MIT license.



## Topics

### Articles

- <doc:Getting-Started-Article>

### Essentials

- ``AlertContext``
- ``AlertContent``
- ``FullScreenCoverContext``
- ``SheetContext``
- ``ValuePresentation``

### Errors

- ``ErrorAlerter``
- ``ErrorAlertConvertible``

### Legacy

- ``AnyErrorAlerter``
- ``AnyPresentation``
- ``AnyAlertContext``
- ``AnyFullScreenCoverContext``
- ``AnySheetContext``

### Navigation

- ``NavigationButton``
- ``NavigationChevron``
- ``NavigationContext``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Project]: https://github.com/danielsaidi/PresentationKit
