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
            url: "https://github.com/audulus/openvdb-spm/releases/download/v5/openvdb.xcframework.zip",
            checksum: "f54fdd354ee7f19e17c966ef71786f5c1d2b6435caa181d07d18583fff25fcf7"
        )
    ]
)
