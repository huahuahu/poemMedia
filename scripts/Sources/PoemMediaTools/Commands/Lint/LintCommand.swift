import ArgumentParser
import Foundation

struct LintCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "lint",
        abstract: "Lint Swift files using SwiftLint and SwiftFormat"
    )
    
    @Option(name: .shortAndLong, help: "Path to lint")
    var path: String = "."
    
    @Flag(name: .long, help: "Only check for issues, don't fix them")
    var check = false
    
    @Flag(name: .long, help: "Fix issues automatically")
    var fix = false
    
    func run() throws {
        let currentPath = URL(fileURLWithPath: path)
        
        print("🔍 Linting Swift files in: \(currentPath.path)")
        
        if fix {
            print("🔧 Running SwiftFormat to fix formatting issues...")
            try runSwiftFormat(path: currentPath.path)
        }
        
        print("📝 Running SwiftLint...")
        try runSwiftLint(path: currentPath.path, autoCorrect: fix && !check)
    }
}