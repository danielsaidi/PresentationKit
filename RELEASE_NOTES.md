# Release Notes

[PresentationKit](https://github.com/danielsaidi/PresentationKit) uses semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if the alternative is worse.

Beta version tags are removed after the next minor or major version. 

These release notes only cover the current major version.



## 1.4.1

This version adds more navigation support.

### ✨ Features

* The `NavigationDestinationStack` is a new custom stack view. 



## 1.4

This version adds more navigation support.

### ✨ Features

* The `NavigationDestination` protocol can be impemented by any hashable type. 
* The native `NavigationStack` has a new `NavigationDestination`-based initializer. 



## 1.3.2

This version adjusts `View+Alert` to resolve strange Swift 6 toolchain bugs with disfavored overloads.  



## 1.3.1

This version adds localized toast support.

### ✨ Features

* The `ToastMessage` can now be created with a `LocalizedStringResource`. 



## 1.3

This version adds toast support.

### ✨ Features

* The library now supports presenting toast messages with a `Presentation` value. 
* The `.alert(for:)` modifier has a new alternative that lets you customize the default values.
* The `.toast(for:content:)` modifier can be used to present toasts with a presentation binding. 



## 1.2

This version makes a few breaking changes to the library, despite the semantic versioning.

The reason for this is that the library still has few users, and the alternative is worse. 

### ✨ Features

* The `.alert(for:content:)` modifier now lets you return `nil` to avoid alerting.

### 💡 Changes

* The `ErrorAlerter` now has an `alertError` instead of an `errorContext`.
* The `NavigationContext` is renamed to `Navigation`.
* The `PresentationContext` is renamed to `Presentation`.



## 1.1

This version makes a breaking change to the library, despite the semantic versioning.

The reason for this is that the library still has very few users, and the alternative is worse. 

### 💡 Changes

* `AlertMessage` is non-generic and supports `String` and `LocalizedStringResource` instead of `LocalizedStringKey`.



## 1.0

This version removes a lot of legacy protocols and models and makes the library cleaner.

### ✨ Features

* `NavigationButton` can be styled with `.navigationChevronStyle`.
* `NavigationChevron` can be styled with `.navigationChevronStyle`.
* `NavigationChevronStyle` is a new `NavigationChevron` style type.
* `PresentationContext` is a new context that replaces the old ones.
* `View` has new `.alert`, `.fullScreenCover`, and `.sheet` modifiers for the context.
* `View` has a new `.presentationDetents(_:additional:) modifier for intrinsic sizing.
* `View` has a new `.presentationDetents(animated:manual:) modifier for animated resizing.

### 💥 Breaking Changes

* `AnyAlertContext` has been removed.
* `AnyErrorAlerter` has been removed.
* `AnyFullScreenCoverContext` has been removed.
* `AnySheetContext` has been removed.
* `AnyPresentation` has been removed.
* `AlertContext` has been replaced with `PresentationContext`.
* `ErrorAlertConvertible` has been renamed to `AlertError`.
* `ModelPresentation` has been removed.
* `FullScreenCoverContext` has been replaced with `PresentationContext`.
* `SheetContext` has been replaced with `PresentationContext`.
* `View.presentation(...)` has been removed.



## 0.5

This version makes the SDK use Swift 6.1 and bumps the demo to Xcode 26.



## 0.4.2

This version adds a `.popToRoot()` to `NavigationContext`.



## 0.4.1

This version makes the navigation context initializer public.



## 0.4

This version adds new legacy models, which can be used to present any alerts or views.



## 0.3.1

This version adds new error utilities.

### ✨ Features

* `.presentation(...)` can now be used with non-identifiable errors.
* `.presentation(...)` can now be used with `ErrorAlertConvertible` types.



## 0.3

This version adds new error utilities.

### ✨ Features

* `ErrorAlerter` can be implemented to make it easy to handle errors.

### 💡 Changes

* `PresentationContext` no longer requires models to be identifiable.



## 0.2

This version adds new navigation utilities.

### ✨ Features

* `NavigationButton` can be used to render a `Button` as a `NavigationLink`.
* `NavigationChevron` can be used to mimic a native navigation chevron.
* `NavigationContext` can be used to manage an observable navigation path.



## 0.1

This is the first public release of PresentationKit.

### ✨ Features

* `AlertContext` can be used to present alerts.
* `SheetContext` can be used to present sheets.
* `FullScreenCoverContext` can be used to present modals.
* `View+Presentation` has many presentation view extensions.
