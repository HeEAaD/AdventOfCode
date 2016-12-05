import PackageDescription

let package = Package(
    name: "Day05"
)

package.dependencies = [
    .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", majorVersion: 0)
]
