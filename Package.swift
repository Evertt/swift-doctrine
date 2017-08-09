// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Doctrine",
    products: [
        .library(name: "ORM", targets: ["ORM"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/node.git", .revision("swift-4")),
        .package(url: "https://github.com/Evertt/swift-id.git", .revision("4.0")),
        .package(url: "https://github.com/Evertt/Reflection-Extensions.git", .revision("4.0")),
    ],
    targets: [
        .target(name: "NodeExtension", dependencies: ["ID", "Node", "ReflectionExtensions"]),
        .target(name: "ORM", dependencies: ["NodeExtension"]),

        .testTarget(name: "ORMTests", dependencies: ["ORM", "Node"])
    ]
)
