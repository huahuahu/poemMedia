// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PoemMediaTools",
  platforms: [.macOS(.v14)],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
  ],
  targets: [
    .binaryTarget(
      name: "swiftformat",
      url: "https://github.com/nicklockwood/SwiftFormat/releases/download/0.58.5/swiftformat.artifactbundle.zip",
      checksum: "f0fc3dd92c44e0ff3b856042865559c5aec175419661139da106768fbace3158"
    ),
    .binaryTarget(
      name: "swiftLint",
      url: "https://github.com/realm/SwiftLint/releases/download/0.62.1/SwiftLintBinary.artifactbundle.zip",
      checksum: "7be75aeb533dd91e66e1d47123828643d7fa606807de1b0335c3cc14d2d1abc2"
    ),
    .executableTarget(
      name: "tools",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ],
      path: "Sources/PoemMediaTools"
    ),
  ]
)
