// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Arrow",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2)],
    products: [.library(name: "Arrow", targets: ["Arrow"])],
    targets: [
        .target(name: "Arrow"),
        .testTarget(name: "ArrowTests", dependencies: ["Arrow"])
    ]
)
