import ArgumentParser
import Foundation

struct BuildCommand: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "build",
    abstract: "Build Xcode project"
  )

  // @Option(name: .shortAndLong, help: "Path to Xcode project (.xcodeproj)")
  // var project: String

  // @Option(name: .shortAndLong, help: "Scheme to build")
  // var scheme: String

  // @Option(name: .shortAndLong, help: "Configuration to build (Debug/Release)")
  // var configuration = "Debug"

  // @Option(name: .long, help: "Destination for build")
  // var destination = "generic/platform=iOS Simulator"

  @Flag(name: .long, help: "Clean before building") var clean = false

  func run() throws {
    // print("🏗️  Building Xcode project: \(project)")
    // print("📱 Scheme: \(scheme)")
    // print("⚙️  Configuration: \(configuration)")

    // var buildArgs = [
    //   "xcodebuild",
    //   "-project", project,
    //   "-scheme", scheme,
    //   "-configuration", configuration,
    //   "-destination", destination,
    // ]

    var buildArgs = [
      "xcodebuild",
      "-project", "PoemMedia.xcodeproj",
      "-scheme", "PoemMedia",
      "-configuration", "Debug",
      "-destination", "generic/platform=iOS Simulator",
    ]

    // if clean {
    //   print("🧹 Cleaning project first...")
    //   let cleanArgs = buildArgs + ["clean"]
    //   try XcodeBuildUtilities.runXcodeBuild(arguments: cleanArgs)
    // }

    buildArgs.append("build")
    try XcodeBuildUtilities.runXcodeBuild(arguments: buildArgs)

    print("✅ Build completed successfully!")
  }
}
