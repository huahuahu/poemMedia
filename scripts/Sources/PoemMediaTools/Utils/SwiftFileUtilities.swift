import Foundation

struct SwiftFileUtilities {
    static func findSwiftFiles(in path: String) throws -> [String] {
        let fileManager = FileManager.default
        var swiftFiles: [String] = []
        
        let enumerator = fileManager.enumerator(atPath: path)
        while let file = enumerator?.nextObject() as? String {
            if file.hasSuffix(".swift") {
                let fullPath = URL(fileURLWithPath: path).appendingPathComponent(file).path
                swiftFiles.append(fullPath)
            }
        }
        
        return swiftFiles
    }
}