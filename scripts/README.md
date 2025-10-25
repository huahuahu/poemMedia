# PoemMedia Tools

This Swift package provides a unified command-line tool for common development tasks in the PoemMedia project.

## Installation

1. Navigate to the scripts directory:
   ```bash
   cd scripts
   ```

2. Build the package:
   ```bash
   swift build -c release
   ```

3. (Optional) Install the tool globally:
   ```bash
   sudo cp .build/release/PoemMediaTools /usr/local/bin/
   ```

## Usage

### Building the tool

```bash
cd scripts
swift build -c release
```

### Linting Swift files

```bash
# Check code style only
./.build/release/PoemMediaTools lint --check --path ../ios/

# Check and fix code style
./.build/release/PoemMediaTools lint --fix --path ../ios/

# Or using swift run during development
swift run PoemMediaTools lint --check --path ../ios/
swift run PoemMediaTools lint --fix --path ../ios/
```

### Building Xcode project

```bash
./.build/release/PoemMediaTools build --project ../ios/PoemMedia/PoemMedia.xcodeproj --scheme PoemMedia

# Or using swift run during development
swift run PoemMediaTools build --project ../ios/PoemMedia/PoemMedia.xcodeproj --scheme PoemMedia

# Build with different configurations
swift run PoemMediaTools build --project ../ios/PoemMedia/PoemMedia.xcodeproj --scheme PoemMedia --configuration Release

# Clean before building
swift run PoemMediaTools build --project ../ios/PoemMedia/PoemMedia.xcodeproj --scheme PoemMedia --clean
```

## Project Structure

```
scripts/
├── Package.swift                 # Swift package configuration
├── Sources/
│   ├── LintTask/
│   │   └── main.swift           # Lint tool implementation
│   └── BuildTask/
│       └── main.swift           # Build tool implementation
└── README.md                    # This file
```

## Development

### Adding New Tasks

1. Create a new target in `Package.swift`:
   ```swift
   .executableTarget(
       name: "NewTask",
       dependencies: [
           .product(name: "ArgumentParser", package: "swift-argument-parser")
       ],
       path: "Sources/NewTask"
   )
   ```

2. Add the product:
   ```swift
   .executable(name: "newtask", targets: ["NewTask"])
   ```

3. Create the source directory and implement your task:
   ```bash
   mkdir Sources/NewTask
   # Implement your task in Sources/NewTask/main.swift
   ```

### Running Tests

Currently, there are no tests implemented. To add tests, create a `Tests` directory and add test targets to the package.

## Troubleshooting

### SwiftLint/SwiftFormat Not Found

If you get errors about SwiftLint or SwiftFormat not being found:

1. Install via Homebrew:
   ```bash
   brew install swiftlint swiftformat
   ```

2. Or install via Mint:
   ```bash
   mint install realm/SwiftLint
   mint install nicklockwood/SwiftFormat
   ```

### Xcode Build Errors

If you encounter build errors:

1. Make sure you're in the correct directory
2. Verify the project/workspace exists at the specified path
3. Check that the scheme name is correct
4. Try cleaning the project first with `--clean`

### Permission Errors

If you get permission errors when installing globally:
```bash
# Create a local bin directory
mkdir -p ~/.local/bin
cp .build/release/* ~/.local/bin/
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```