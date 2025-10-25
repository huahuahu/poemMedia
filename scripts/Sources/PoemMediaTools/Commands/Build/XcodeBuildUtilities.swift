import Foundation

struct XcodeBuildUtilities {
    static func runXcodeBuild(arguments: [String]) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/xcodebuild")
        process.arguments = Array(arguments.dropFirst()) // Remove "xcodebuild" from args
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            print(output)
        }
        
        if process.terminationStatus != 0 {
            throw NSError(
                domain: "BuildError",
                code: Int(process.terminationStatus),
                userInfo: [NSLocalizedDescriptionKey: "xcodebuild failed with exit code \(process.terminationStatus)"]
            )
        }
    }
}