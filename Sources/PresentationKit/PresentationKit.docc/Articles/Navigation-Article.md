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

You can also make any hashable type implement the ``NavigationDestination`` protocol, to make it possible to use it with a value-based navigation stack.

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

You can then create a navigation stack that is specialized for this custom type: 

```swift
struct MyApp: View {
    
    @State var navigation = Navigation<MyAppScreen>()
    
    var body: some View {
        NavigationStack(
            root: MyAppScreen.home,
            navigation: navigation
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
