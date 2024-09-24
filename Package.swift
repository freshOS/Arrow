// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Arrow",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v4)],
    products: [.library(name: "Arrow", targets: ["Arrow"])],
    targets: [
        .target(name: "Arrow", path: "Sources", resources: [.copy("PrivacyInfo.xcprivacy")]),
        .testTarget(name: "ArrowTests", dependencies: ["Arrow"])
    ]
)
