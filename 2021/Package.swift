// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "2021",
	dependencies: [
	],
	targets: [
		.executableTarget(name: "Day01", dependencies: []),
		.executableTarget(name: "Day02", dependencies: []),
		.executableTarget(name: "Day03", dependencies: []),
		.executableTarget(name: "Day04", dependencies: []),
		.executableTarget(name: "Day05", dependencies: []),
		.executableTarget(name: "Day06", dependencies: []),
		.executableTarget(name: "Day07", dependencies: []),
        .executableTarget(name: "Day10", dependencies: []),
        .executableTarget(name: "Day11", dependencies: []),
        .executableTarget(name: "Day12", dependencies: []),
        .executableTarget(name: "Day13", dependencies: []),
        .executableTarget(name: "Day14", dependencies: []),
	]
)
