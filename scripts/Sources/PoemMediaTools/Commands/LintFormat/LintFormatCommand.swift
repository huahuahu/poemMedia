import ArgumentParser
import Foundation

struct LintFormatCommand: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "lint-format",
    abstract: "Run SwiftLint and SwiftFormat on the codebase"
  )

  @Flag(name: .long, help: "Apply fixes automatically instead of just checking") var fix = false

  @Flag(name: .long, help: "Run only SwiftFormat") var formatOnly = false

  @Flag(name: .long, help: "Run only SwiftLint") var lintOnly = false

  func run() throws {
    let workspaceRoot = WorkspaceUtilities.findWorkspaceRoot()
    print("📁 Workspace root: \(workspaceRoot)")

    var hasErrors = false

    // Run SwiftLint
    if !lintOnly {
      print("\n🔍 Running SwiftLint...")
      do {
        try LintFormatUtilities.runSwiftLint(
          workspaceRoot: workspaceRoot,
          shouldFix: fix
        )
        print("✅ SwiftLint completed successfully!")
      } catch {
        print("❌ SwiftLint failed: \(error.localizedDescription)")
        hasErrors = true
      }
    }

    if hasErrors {
      throw ExitCode.failure
    }

    // Run SwiftFormat
    if !formatOnly {
      print("\n🎨 Running SwiftFormat...")
      do {
        try LintFormatUtilities.runSwiftFormat(
          workspaceRoot: workspaceRoot,
          shouldFix: fix
        )
        print("✅ SwiftFormat completed successfully!")
      } catch {
        print("❌ SwiftFormat failed: \(error.localizedDescription)")
        hasErrors = true
      }
    }

    // Exit with error if any checks failed
    if hasErrors {
      throw ExitCode.failure
    }

    print("\n✨ All checks passed!")
  }
}
