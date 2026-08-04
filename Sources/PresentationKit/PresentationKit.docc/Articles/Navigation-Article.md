# Navigation

The ``Navigation`` class can be used to perform value-based navigation.

## Overview

The ``Navigation`` class can be used to perform value-based navigation. The ``Navigation/path`` can be bound to a ``SwiftUI/NavigationStack``, and used to push and pop content to the stack.

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

You can also make any type implement the ``NavigationDestination`` protocol, to use it with a value-based ``SwiftUI/NavigationStack``.

```swift
enum MyAppScreen: String, NavigationDestination {
    case home, settings
    
    @ViewBuilder
    var destinationContent: some View {
        switch self {
        case .home:
            NavigationLink(value: MyAppScreen.settings) {
                Text("Open Settings")
            }
        case .settings:
            Text("Settings")
        }
    }
}
```

You can then create a ``SwiftUI/NavigationStack`` that is bound to this specific type, and navigate by using values of that specific type: 

```swift
struct MyApp: View {
    
    @State var navigation = Navigation<MyAppScreen>()
    
    var body: some View {
        NavigationStack(
            root: MyAppScreen.home,
            navigation: navigation
        )
        
        // ...or, to use an internal navigation state
        
        NavigationDestinationStack(
            root: MyAppScreen.home
        )
    }
}
```

This will inject the ``Navigation`` value into the environment, so that all destination views in the stack can access the navigation path. 
    

## Topics

- ``Navigation``
- ``NavigationButton``
- ``NavigationChevron``
- ``NavigationChevronStyle``
- ``NavigationDestination``
- ``NavigationDestinationContent``
- ``NavigationDestinationStack``
