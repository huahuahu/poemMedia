import Foundation

enum XcodeBuildUtilities {
  static func runXcodeBuild(arguments: [String]) throws {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process
      .arguments = ["xcodebuild"] + Array(arguments.dropFirst()) // Remove "xcodebuild" from args

    let outputPipe = Pipe()
    let errorPipe = Pipe()
    process.standardOutput = outputPipe
    process.standardError = errorPipe

    // Add debug print statement for process run
    print("Running xcodebuild with arguments: \(arguments)")

    // Stream output in real-time
    outputPipe.fileHandleForReading.readabilityHandler = { handle in
      let data = handle.availableData
      if !data.isEmpty, let output = String(data: data, encoding: .utf8) {
        print(output, terminator: "")
      }
    }

    errorPipe.fileHandleForReading.readabilityHandler = { handle in
      let data = handle.availableData
      if !data.isEmpty, let output = String(data: data, encoding: .utf8) {
        print(output, terminator: "")
      }
    }

    try process.run()
    process.waitUntilExit()

    // Clean up handlers
    outputPipe.fileHandleForReading.readabilityHandler = nil
    errorPipe.fileHandleForReading.readabilityHandler = nil

    if process.terminationStatus != 0 {
      throw NSError(
        domain: "BuildError",
        code: Int(process.terminationStatus),
        userInfo: [
          NSLocalizedDescriptionKey: "xcodebuild failed with exit code \(process.terminationStatus)",
        ]
      )
    }
  }
}
