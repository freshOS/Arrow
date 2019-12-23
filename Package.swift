// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Arrow",
    platforms: [.iOS(.v8)],
    products: [.library(name: "Arrow", targets: ["Arrow"])],
    targets: [
        .target(name: "Arrow", path: "Source"),
        .testTarget(name: "ArrowTests", dependencies: ["Arrow"], path: "ArrowTests")
    ]
)
