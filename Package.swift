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
            url: "https://github.com/audulus/openvdb-spm/releases/download/v2/openvdb.xcframework.zip",
            checksum: "826f8eaeb500297d64c9fd6ead487d28a9036c27e4ebbc753466828f36d0b2a3"
        )
    ]
)
