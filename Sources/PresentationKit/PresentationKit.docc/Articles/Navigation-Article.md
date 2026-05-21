# Navigation

Use the ``Navigation`` class to perform value-based navigation.

## Overview

The observable ``Navigation`` class makes it easy to perform value-based navigation. The ``Navigation/path`` can be bound to a navigation stack, and used to push and pop content to the stack.

```swift
struct MyView: View {

    @State var navigation = Navigation()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                Button("Push view") {
                    navigation.push("detail")
                }
            }
            .navigationDestination(for: String.self) { value in
                Text(value)
            }
        }
    }
}
```

## Topics

- ``Navigation``
- ``NavigationButton``
- ``NavigationChevron``
- ``NavigationChevronStyle``
