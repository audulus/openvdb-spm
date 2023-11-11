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
            url: "https://github.com/audulus/openvdb-spm/releases/download/v4/openvdb.xcframework.zip",
            checksum: "2ac52d986bfef7ce2ab5baeac621e4e7f8da895db309916e63d94e3122e93b8e"
        )
    ]
)
