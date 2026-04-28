# Release Notes

[PresentationKit](https://github.com/danielsaidi/PresentationKit) will use semver after 1.0.

Until then, breaking changes can happen in any version, and deprecations may be removed in any minor version bump.



## 1.0

This version removes a lot of legacy protocols and models.

### ✨ New Features

* `PresentationContext` is a new context that replaces the old ones.


### 💥 Breaking Changes

* `AnyAlertContext` has been removed.
* `AnyErrorAlerter` has been removed.
* `AnyFullScreenCoverContext` has been removed.
* `AnySheetContext` has been removed.
* `AnyPresentation` has been removed.
* `AlertContext` has been replaced with `PresentationContext`.
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
