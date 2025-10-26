import Foundation

enum ToolConfiguration {
  static let swiftformatPath = "scripts/.build/artifacts/scripts/swiftformat/swiftformat.artifactbundle/swiftformat-0.58.5-macos/bin/swiftformat"
  static let swiftlintPath = "scripts/.build/artifacts/scripts/swiftLint/SwiftLintBinary.artifactbundle/macos/swiftlint"

  // Xcode project settings
  static let xcodeProjectPath = "ios/PoemMedia/PoemMedia.xcodeproj"
  static let scheme = "PoemMedia"
  static let configuration = "Debug"
  static let destination = "platform=iOS Simulator,name=iPhone 17 Pro"
}
