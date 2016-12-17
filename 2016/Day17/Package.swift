import PackageDescription

let package = Package(
    name: "Day17",
    dependencies: [
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", majorVersion: 0)
    ]
)
