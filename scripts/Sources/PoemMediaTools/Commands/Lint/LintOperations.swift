import Foundation

extension LintCommand {
    func runSwiftFormat(path: String) throws {
        let swiftFiles = try SwiftFileUtilities.findSwiftFiles(in: path)
        
        for file in swiftFiles {
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/which")
            process.arguments = ["swiftformat"]
            
            let whichPipe = Pipe()
            process.standardOutput = whichPipe
            
            do {
                try process.run()
                process.waitUntilExit()
                
                let whichData = whichPipe.fileHandleForReading.readDataToEndOfFile()
                let swiftformatPath = String(data: whichData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "swiftformat"
                
                let formatProcess = Process()
                formatProcess.executableURL = URL(fileURLWithPath: swiftformatPath)
                formatProcess.arguments = [file]
                
                let formatPipe = Pipe()
                formatProcess.standardOutput = formatPipe
                formatProcess.standardError = formatPipe
                
                try formatProcess.run()
                formatProcess.waitUntilExit()
                
                if formatProcess.terminationStatus == 0 {
                    print("✅ Formatted: \(file)")
                } else {
                    let errorData = formatPipe.fileHandleForReading.readDataToEndOfFile()
                    let errorMessage = String(data: errorData, encoding: .utf8) ?? "Unknown error"
                    print("❌ Failed to format \(file): \(errorMessage)")
                }
            } catch {
                print("❌ Failed to format \(file): \(error)")
            }
        }
    }
    
    func runSwiftLint(path: String, autoCorrect: Bool) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/which")
        process.arguments = ["swiftlint"]
        
        let whichPipe = Pipe()
        process.standardOutput = whichPipe
        
        do {
            try process.run()
            process.waitUntilExit()
            
            let whichData = whichPipe.fileHandleForReading.readDataToEndOfFile()
            let swiftlintPath = String(data: whichData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "swiftlint"
            
            let lintProcess = Process()
            lintProcess.executableURL = URL(fileURLWithPath: swiftlintPath)
            lintProcess.currentDirectoryURL = URL(fileURLWithPath: path)
            
            var arguments = ["lint"]
            if autoCorrect {
                arguments.append("--autocorrect")
            }
            
            lintProcess.arguments = arguments
            
            let lintPipe = Pipe()
            lintProcess.standardOutput = lintPipe
            lintProcess.standardError = lintPipe
            
            try lintProcess.run()
            lintProcess.waitUntilExit()
            
            let lintData = lintPipe.fileHandleForReading.readDataToEndOfFile()
            let lintOutput = String(data: lintData, encoding: .utf8) ?? ""
            
            if !lintOutput.isEmpty {
                print(lintOutput)
            }
            
            if lintProcess.terminationStatus == 0 {
                print("✅ SwiftLint completed successfully!")
            }
        } catch {
            print("❌ Failed to run SwiftLint: \(error)")
        }
    }
}