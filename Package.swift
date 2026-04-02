// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift-design-system",
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
    ],
    targets: [
        .target(
            name: "DesignSystem"
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"]
        ),
    ]
)
