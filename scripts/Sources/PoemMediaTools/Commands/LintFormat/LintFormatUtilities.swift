import Foundation

enum LintFormatUtilities {
  /// Run SwiftFormat on the workspace
  /// - Parameters:
  ///   - workspaceRoot: The root directory of the workspace
  ///   - shouldFix: If true, applies fixes. If false, only checks formatting
  static func runSwiftFormat(workspaceRoot: String, shouldFix: Bool) throws {
    let swiftformatBinary = workspaceRoot + "/" + ToolConfiguration.swiftformatPath
    let configFile = workspaceRoot + "/.swiftformat"

    // Check if binary exists
    guard FileManager.default.fileExists(atPath: swiftformatBinary) else {
      throw NSError(
        domain: "LintFormatError",
        code: 1,
        userInfo: [
          NSLocalizedDescriptionKey: "SwiftFormat binary not found at: \(swiftformatBinary)",
        ]
      )
    }

    // Check if config file exists
    guard FileManager.default.fileExists(atPath: configFile) else {
      throw NSError(
        domain: "LintFormatError",
        code: 1,
        userInfo: [
          NSLocalizedDescriptionKey: "SwiftFormat config not found at: \(configFile)",
        ]
      )
    }

    let process = Process()
    process.executableURL = URL(fileURLWithPath: swiftformatBinary)

    var arguments = [
      "--config", configFile,
      workspaceRoot,
    ]

    // If not fixing, add --lint flag to only check
    if !shouldFix {
      arguments.insert("--lint", at: 0)
    }

    process.arguments = arguments
    process.currentDirectoryURL = URL(fileURLWithPath: workspaceRoot)

    print("Running SwiftFormat with arguments: \(arguments.joined(separator: " "))")
    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe

    try process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8), !output.isEmpty {
      print(output)
    }

    if process.terminationStatus != 0 {
      throw NSError(
        domain: "LintFormatError",
        code: Int(process.terminationStatus),
        userInfo: [
          NSLocalizedDescriptionKey: "SwiftFormat failed with exit code \(process.terminationStatus)",
        ]
      )
    }
  }

  /// Run SwiftLint on the workspace
  /// - Parameters:
  ///   - workspaceRoot: The root directory of the workspace
  ///   - shouldFix: If true, applies autocorrect. If false, only lints
  static func runSwiftLint(workspaceRoot: String, shouldFix: Bool) throws {
    let swiftlintBinary = workspaceRoot + "/" + ToolConfiguration.swiftlintPath
    let configFile = workspaceRoot + "/.swiftlint.yml"

    // Check if binary exists
    guard FileManager.default.fileExists(atPath: swiftlintBinary) else {
      throw NSError(
        domain: "LintFormatError",
        code: 1,
        userInfo: [
          NSLocalizedDescriptionKey: "SwiftLint binary not found at: \(swiftlintBinary)",
        ]
      )
    }

    // Check if config file exists
    guard FileManager.default.fileExists(atPath: configFile) else {
      throw NSError(
        domain: "LintFormatError",
        code: 1,
        userInfo: [
          NSLocalizedDescriptionKey: "SwiftLint config not found at: \(configFile)",
        ]
      )
    }

    let process = Process()
    process.executableURL = URL(fileURLWithPath: swiftlintBinary)

    var arguments = [
      "--config", configFile,
    ]

    // Choose between lint and autocorrect
    if shouldFix {
      arguments.insert("--fix", at: 0)
    } else {
      arguments.insert("lint", at: 0)
      // Set strict mode to fail on warnings (only in lint mode)
      //   arguments.append("--strict")
    }

    process.arguments = arguments
    process.currentDirectoryURL = URL(fileURLWithPath: workspaceRoot)

    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe

    // output process info for debugging
    print("Running SwiftLint with arguments: \(arguments.joined(separator: " "))")
    try process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8), !output.isEmpty {
      print(output)
    }

    if process.terminationStatus != 0 {
      throw NSError(
        domain: "LintFormatError",
        code: Int(process.terminationStatus),
        userInfo: [
          NSLocalizedDescriptionKey: "SwiftLint failed with exit code \(process.terminationStatus)",
        ]
      )
    }
  }
}
