import ArgumentParser

@main
struct PoemMediaTools: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "PoemMedia development tools",
    subcommands: [BuildCommand.self, LintFormatCommand.self, RSSGeneratorCommand.self],
    defaultSubcommand: BuildCommand.self
  )
}
