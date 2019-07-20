// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "XcodeReleasesKit",
    products: [
        .library(
            name: "XcodeReleasesKit",
            targets: ["XcodeReleasesKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "XcodeReleasesKit",
            dependencies: []),
        .testTarget(
            name: "XcodeReleasesKitTests",
            dependencies: ["XcodeReleasesKit"]),
    ]
)
