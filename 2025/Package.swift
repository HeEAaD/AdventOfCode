// swift-tools-version:6.2

import PackageDescription

let package = Package(
    name: "2025",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(name: "Day01"),
        .executableTarget(name: "Day02"),
        .executableTarget(name: "Day03"),
        .executableTarget(name: "Day04"),
        .executableTarget(name: "Day05"),
        .executableTarget(name: "Day06"),
        .executableTarget(name: "Day07"),
        .executableTarget(name: "Day08"),
        .executableTarget(name: "Day09"),
        .executableTarget(name: "Day11"),
    ]
)
