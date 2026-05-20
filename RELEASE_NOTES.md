# Release Notes

[PresentationKit](https://github.com/danielsaidi/PresentationKit) uses semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if the alternative is worse.

Beta version tags are removed after the next minor or major version. 

These release notes only cover the current major version.



## 1.1.1

This version makes it possible to not return `nil` to avoid presenting an alert.

### 💡 Adjustments

* The `.alert(for:content:)` modifier now allows you to return `nil` to avoid presenting an alert.



## 1.1

This version simplifies the `AlertMessage` to be non-generic.

This is a breaking change, but the alternative was worse, after running into problems.

### 💡 Adjustments

* `AlertMessage` is non-generic and supports `String` and `LocalizedStringResource` instead of `LocalizedStringKey`.



## 1.0

This version removes a lot of legacy protocols and models and makes the library cleaner.

### ✨ New Features

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

### ✨ New Features

* `.presentation(...)` can now be used with non-identifiable errors.
* `.presentation(...)` can now be used with `ErrorAlertConvertible` types.



## 0.3

This version adds new error utilities.

### ✨ New Features

* `ErrorAlerter` can be implemented to make it easy to handle errors.

### 💡 Adjustments

* `PresentationContext` no longer requires models to be identifiable.



## 0.2

This version adds new navigation utilities.

### ✨ New Features

* `NavigationButton` can be used to render a `Button` as a `NavigationLink`.
* `NavigationChevron` can be used to mimic a native navigation chevron.
* `NavigationContext` can be used to manage an observable navigation path.



## 0.1

This is the first public release of PresentationKit.

### ✨ New Features

* `AlertContext` can be used to present alerts.
* `SheetContext` can be used to present sheets.
* `FullScreenCoverContext` can be used to present modals.
* `View+Presentation` has many presentation view extensions.
