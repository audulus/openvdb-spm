// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "openvdb",
    platforms: [
        .macOS(.v11), .iOS(.v13)
    ],
    products: [
        .library(
            name: "openvdb",
            targets: ["openvdb"])
    ],
    targets: [
        .binaryTarget(
            name: "openvdb",
            url: "https://github.com/audulus/openvdb-spm/releases/download/v1/openvdb.xcframework.zip",
            checksum: "f99e1bf0f44760a793bbc949e0012b0d1a4558c58313a9c1c6cfb1686290bc50"
        )
    ]
)
