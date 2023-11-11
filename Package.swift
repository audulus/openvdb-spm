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
            url: "https://github.com/audulus/openvdb-spm/releases/download/v3/openvdb.xcframework.zip",
            checksum: "fe7013c620730dade109c47854ade8c1ef82df619f744ab2b14a9c41516706ce"
        )
    ]
)
