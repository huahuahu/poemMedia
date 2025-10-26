# PoemMedia Tools

This Swift package provides a unified command-line tool for common development tasks in the PoemMedia project.

## Installation

1. Navigate to the scripts directory:
   ```bash
   cd scripts
   ```

2. Build the package:
   ```bash
   swift build
   ```

## Usage

### Building the tool

```bash
cd scripts
swift build
```

The executable will be located at `.build/arm64-apple-macosx/debug/tools` (or similar path depending on your architecture and build configuration).

### Build Command

Build the Xcode project:

```bash
.build/arm64-apple-macosx/debug/tools build

# Clean before building
.build/arm64-apple-macosx/debug/tools build --clean
```

### Lint and Format Command

Run SwiftLint and SwiftFormat on the codebase:

```bash
# Check mode (default) - verify formatting without making changes
.build/arm64-apple-macosx/debug/tools lint-format

# Fix mode - automatically apply fixes
.build/arm64-apple-macosx/debug/tools lint-format --fix

# Run only SwiftFormat
.build/arm64-apple-macosx/debug/tools lint-format --format-only

# Run only SwiftLint
.build/arm64-apple-macosx/debug/tools lint-format --lint-only

# Show help
.build/arm64-apple-macosx/debug/tools lint-format --help
```

**Note**: 
- In check mode (without `--fix`), the command will exit with a non-zero code if any formatting issues or lint violations are found, making it suitable for CI pipelines.
- SwiftFormat uses the `.swiftformat` config file at the workspace root
- SwiftLint uses the `.swiftlint.yml` config file at the workspace root
- Binary tools are automatically downloaded as Swift package dependencies

## CI Integration

To use in CI/CD pipelines:

```bash
cd scripts
swift build
.build/arm64-apple-macosx/debug/tools lint-format
```

The command will fail (exit code 1) if any formatting or linting issues are detected.

## Project Structure

```
scripts/
├── Package.swift                             # Swift package configuration
├── Sources/
│   └── PoemMediaTools/
│       ├── entry.swift                       # Main entry point
│       ├── Commands/
│       │   ├── Build/
│       │   │   ├── BuildCommand.swift        # Build command
│       │   │   └── XcodeBuildUtilities.swift # Xcode build utilities
│       │   └── LintFormat/
│       │       ├── LintFormatCommand.swift   # Lint/format command
│       │       └── LintFormatUtilities.swift # Lint/format utilities
│       └── Utils/
│           ├── WorkspaceUtilities.swift      # Workspace helpers
│           └── ToolConfiguration.swift       # Tool paths configuration
└── README.md                                 # This file
```

## Development

### Adding New Commands

1. Create a new command file implementing `ParsableCommand`:
   ```swift
   import ArgumentParser
   
   struct MyCommand: ParsableCommand {
     static let configuration = CommandConfiguration(
       commandName: "my-command",
       abstract: "Description of my command"
     )
     
     func run() throws {
       // Implementation
     }
   }
   ```

2. Register it in `entry.swift`:
   ```swift
   @main
   struct PoemMediaTools: ParsableCommand {
     static let configuration = CommandConfiguration(
       abstract: "PoemMedia development tools",
       subcommands: [BuildCommand.self, LintFormatCommand.self, MyCommand.self],
       defaultSubcommand: BuildCommand.self
     )
   }
   ```

## Troubleshooting

### Binary Tools Not Found

The SwiftFormat and SwiftLint binaries are downloaded automatically as Swift package dependencies. If you get errors:

1. Clean and rebuild:
   ```bash
   swift package clean
   swift build
   ```

2. Check that the artifact bundles are downloaded:
   ```bash
   ls .build/artifacts/scripts/
   ```