import ArgumentParser
import Foundation

// MARK: - BuildCommand

struct BuildCommand: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "xcode-build",
    abstract: "Build, test, and archive Xcode project",
    subcommands: [Build.self, CleanBuild.self, Test.self, Archive.self],
    defaultSubcommand: nil
  )
}

extension BuildCommand {
  struct Build: ParsableCommand {
    static let configuration = CommandConfiguration(
      commandName: "build",
      abstract: "Build the Xcode project"
    )

    @Option(name: .shortAndLong, help: "Build configuration (Debug/Release)")
    var configuration: String = ToolConfiguration.configuration

    func run() throws {
      let workspaceRoot = WorkspaceUtilities.findWorkspaceRoot()
      let projectPath = "\(workspaceRoot)/\(ToolConfiguration.xcodeProjectPath)"

      print("🏗️  Building Xcode project: \(projectPath)")
      print("📱 Scheme: \(ToolConfiguration.scheme)")
      print("⚙️  Configuration: \(configuration)")

      let buildArgs = [
        "xcodebuild",
        "-project", projectPath,
        "-scheme", ToolConfiguration.scheme,
        "-configuration", configuration,
        "-destination", ToolConfiguration.destination,
        "build",
      ]

      try XcodeBuildUtilities.runXcodeBuild(arguments: buildArgs)
      print("✅ Build completed successfully!")
    }
  }

  struct CleanBuild: ParsableCommand {
    static let configuration = CommandConfiguration(
      commandName: "clean-build",
      abstract: "Clean and build the Xcode project"
    )

    @Option(name: .shortAndLong, help: "Build configuration (Debug/Release)")
    var configuration: String = ToolConfiguration.configuration

    func run() throws {
      let workspaceRoot = WorkspaceUtilities.findWorkspaceRoot()
      let projectPath = "\(workspaceRoot)/\(ToolConfiguration.xcodeProjectPath)"

      print("🧹 Cleaning and building Xcode project: \(projectPath)")
      print("📱 Scheme: \(ToolConfiguration.scheme)")
      print("⚙️  Configuration: \(configuration)")

      let baseArgs = [
        "xcodebuild",
        "-project", projectPath,
        "-scheme", ToolConfiguration.scheme,
        "-configuration", configuration,
        "-destination", ToolConfiguration.destination,
      ]

      // Clean first
      print("🧹 Cleaning project...")
      let cleanArgs = baseArgs + ["clean"]
      try XcodeBuildUtilities.runXcodeBuild(arguments: cleanArgs)

      // Then build
      print("🏗️  Building project...")
      let buildArgs = baseArgs + ["build"]
      try XcodeBuildUtilities.runXcodeBuild(arguments: buildArgs)

      print("✅ Clean build completed successfully!")
    }
  }

  struct Test: ParsableCommand {
    static let configuration = CommandConfiguration(
      commandName: "test",
      abstract: "Run tests for the Xcode project"
    )

    @Option(name: .shortAndLong, help: "Build configuration (Debug/Release)")
    var configuration: String = ToolConfiguration.configuration

    func run() throws {
      let workspaceRoot = WorkspaceUtilities.findWorkspaceRoot()
      let projectPath = "\(workspaceRoot)/\(ToolConfiguration.xcodeProjectPath)"

      print("🧪 Running tests for: \(projectPath)")
      print("📱 Scheme: \(ToolConfiguration.scheme)")
      print("⚙️  Configuration: \(configuration)")

      let testArgs = [
        "xcodebuild",
        "-project", projectPath,
        "-scheme", ToolConfiguration.scheme,
        "-configuration", configuration,
        "-destination", ToolConfiguration.destination,
        "test",
      ]

      try XcodeBuildUtilities.runXcodeBuild(arguments: testArgs)
      print("✅ Tests completed successfully!")
    }
  }

  struct Archive: ParsableCommand {
    static let configuration = CommandConfiguration(
      commandName: "archive",
      abstract: "Archive the Xcode project"
    )

    @Option(name: .shortAndLong, help: "Path where the archive will be saved")
    var archivePath = "build/PoemMedia.xcarchive"

    func run() throws {
      let workspaceRoot = WorkspaceUtilities.findWorkspaceRoot()
      let projectPath = "\(workspaceRoot)/\(ToolConfiguration.xcodeProjectPath)"
      let fullArchivePath = "\(workspaceRoot)/\(archivePath)"

      print("📦 Archiving Xcode project: \(projectPath)")
      print("📱 Scheme: \(ToolConfiguration.scheme)")
      print("⚙️  Configuration: Release")
      print("💾 Archive path: \(fullArchivePath)")

      let archiveArgs = [
        "xcodebuild",
        "-project", projectPath,
        "-scheme", ToolConfiguration.scheme,
        "-configuration", "Release",
        "-archivePath", fullArchivePath,
        "archive",
      ]

      try XcodeBuildUtilities.runXcodeBuild(arguments: archiveArgs)
      print("✅ Archive completed successfully!")
      print("📦 Archive saved at: \(fullArchivePath)")
    }
  }
}
