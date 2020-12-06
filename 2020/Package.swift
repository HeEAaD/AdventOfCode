// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "2020",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "Day01", dependencies: []),
        .target(name: "Day02", dependencies: []),
        .target(name: "Day03", dependencies: []),
        .target(name: "Day04", dependencies: []),
        .target(name: "Day05", dependencies: []),
        .target(name: "Day06", dependencies: []),
    ]
)
