import ArgumentParser

@main
struct PoemMediaTools: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "PoemMedia development tools",
        subcommands: [LintCommand.self, BuildCommand.self],
        defaultSubcommand: LintCommand.self
    )
}