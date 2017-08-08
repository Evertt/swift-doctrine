import PackageDescription

let package = Package(
    name: "Doctrine",
    targets: [
        Target(name: "NodeExtension"),
        Target(name: "ORM", dependencies: ["NodeExtension"])
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/node.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/json.git", majorVersion: 2),
        .Package(url: "https://github.com/Evertt/swift-id.git", majorVersion: 0),
        .Package(url: "https://github.com/Evertt/Reflection-Extensions.git", majorVersion: 0),
    ]
)
