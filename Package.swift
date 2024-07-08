// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pageboy",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "Pageboy",
            targets: ["Pageboy"])
    ],
    targets: [
        .target(
            name: "Pageboy",
            path: "Sources/Pageboy",
            exclude: ["Pageboy.h", "PrivacyInfo.xcprivacy"],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .testTarget(
            name: "PageboyTests",
            dependencies: ["Pageboy"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
