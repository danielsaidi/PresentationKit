// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "PresentationKit",
    platforms: [
        .iOS(.v17),
        .tvOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "PresentationKit",
            targets: ["PresentationKit"]
        )
    ],
    targets: [
        .target(
            name: "PresentationKit"
        ),
        .testTarget(
            name: "PresentationKitTests",
            dependencies: ["PresentationKit"]
        )
    ]
)
