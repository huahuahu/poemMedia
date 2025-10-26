import Foundation

enum WorkspaceUtilities {
  static func findWorkspaceRoot(from startPath: String = FileManager.default
    .currentDirectoryPath)
    -> String {
    var currentPath = URL(fileURLWithPath: startPath)

    // Look for common workspace indicators
    while currentPath.path != "/" {
      let gitPath = currentPath.appendingPathComponent(".git")
      if FileManager.default.fileExists(atPath: gitPath.path) {
        return currentPath.path
      }
      currentPath = currentPath.deletingLastPathComponent()
    }

    // If no workspace root found, return the start path
    return startPath
  }
}
