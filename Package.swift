// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Arrow",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2)],
    products: [.library(name: "Arrow", targets: ["Arrow"])],
    targets: [
        .target(name: "Arrow", path: "Sources", resources: [.copy("PrivacyInfo.xcprivacy")]),
        .testTarget(name: "ArrowTests", dependencies: ["Arrow"])
    ]
)
