// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "2018",
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
        .target(name: "Day07", dependencies: []),
        .target(name: "Day09", dependencies: []),
        .target(name: "Day10", dependencies: []),
        .target(name: "Day11", dependencies: []),
        .target(name: "Day12", dependencies: []),
        .target(name: "Day13", dependencies: []),
        .target(name: "Day14", dependencies: []),
        .target(name: "Day16", dependencies: [])
    ]
)
