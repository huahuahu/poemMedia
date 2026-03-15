import ArgumentParser
import Foundation

struct RSSGeneratorCommand: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "rss-generate",
    abstract: "Generate podcast RSS feeds from metadata",
    discussion: """
    Generates RSS feed files for podcasts based on metadata JSON files.
    By default, creates individual feeds for each series plus an all-episodes feed.
    """
  )

  @Option(help: "Output directory for RSS feeds")
  var output: String = "docs/feed"

  @Option(help: "Metadata directory")
  var metadata: String = "metadata"

  @Option(help: "GitHub release version tag")
  var releaseVersion: String = "v1.0.0"

  @Flag(help: "Validate without writing files")
  var validate: Bool = false

  @Flag(help: "Verbose output")
  var verbose: Bool = false

  mutating func run() throws {
    if verbose {
      print("📚 Loading metadata from: \(metadata)")
    }

    let loader = MetadataLoader(metadataPath: metadata)

    // Load podcast configuration
    let podcast = try loader.loadPodcastConfig()
    if verbose {
      print("✅ Loaded podcast: \(podcast.title)")
    }

    // Load all series
    let allSeries = try loader.loadSeries()
    if verbose {
      print("✅ Loaded \(allSeries.count) series")
    }

    // Create output directory if needed
    if !validate {
      try FileManager.default.createDirectory(
        atPath: output,
        withIntermediateDirectories: true,
        attributes: nil
      )
    }

    let builder = XMLBuilder(podcast: podcast, releaseVersion: releaseVersion)
    var generatedFiles = 0

    // Generate "all episodes" feed
    let allEpisodes = allSeries.flatMap { $0.episodes }
    let allFeed = builder.buildFeed(
      title: "叶嘉莹说诗 - 全部系列",
      description: "叶嘉莹先生讲解中国古典诗词的完整系列",
      episodes: allEpisodes,
      feedId: "all"
    )

    if !validate {
      let allPath = "\(output)/all.xml"
      try allFeed.write(toFile: allPath, atomically: true, encoding: .utf8)
      if verbose {
        print("📝 Generated: \(allPath)")
      }
      generatedFiles += 1
    }

    // Generate individual series feeds
    for series in allSeries {
      let feedFileName = seriesIdToFileName(series.id)
      let feed = builder.buildFeed(
        title: series.title,
        description: series.description,
        episodes: series.episodes,
        feedId: series.id
      )

      if !validate {
        let filePath = "\(output)/\(feedFileName).xml"
        try feed.write(toFile: filePath, atomically: true, encoding: .utf8)
        if verbose {
          print("📝 Generated: \(filePath) (\(series.episodes.count) episodes)")
        }
        generatedFiles += 1
      } else if verbose {
        print("✓ Would generate: \(feedFileName).xml (\(series.episodes.count) episodes)")
      }
    }

    // Summary
    let mode = validate ? "validate" : "generate"
    let message = "✅ Successfully \(mode)d \(generatedFiles) RSS feeds from \(allEpisodes.count) episodes"
    print(message)
  }

  // MARK: - Helper Methods

  private func seriesIdToFileName(_ id: String) -> String {
    let mapping: [String: String] = [
      "dufu": "yejiaying-shuo-dufu",
      "jianggao": "yejiaying-shuo-shi-jianggao",
      "chu-sheng-tang": "yejiaying-shuo-chu-sheng-tang-shi",
      "zhong-wan-tang": "yejiaying-shuo-zhong-wan-tang-shi",
      "ruanji": "yejiaying-shuo-ruanji",
      "taoyuanming": "yejiaying-shuo-taoyuanming",
    ]
    return mapping[id] ?? id
  }
}
