import Foundation

struct PodcastConfig: Codable {
  let title: String
  let description: String
  let author: String
  let email: String
  let language: String
  let category: String
  let subcategory: String?
  let explicit: Bool
  let copyright: String
  let websiteUrl: String
}

struct SeriesMetadata: Codable {
  let id: String
  let title: String
  let description: String
  let coverImage: String
  let directory: String
  var episodes: [Episode]

  enum CodingKeys: String, CodingKey {
    case id, title, description, coverImage, directory, episodes
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    description = try container.decode(String.self, forKey: .description)
    coverImage = try container.decode(String.self, forKey: .coverImage)
    directory = try container.decode(String.self, forKey: .directory)
    episodes = try container.decodeIfPresent([Episode].self, forKey: .episodes) ?? []
  }
}

struct Episode: Codable {
  let id: String
  let title: String
  let description: String
  let audioFileName: String
  let duration: Int  // seconds
  let fileSize: Int64
  let pubDate: String  // ISO 8601 format
  let episodeNumber: Int
  let season: Int
}

class MetadataLoader {
  let metadataPath: String

  init(metadataPath: String) {
    self.metadataPath = metadataPath
  }

  func loadPodcastConfig() throws -> PodcastConfig {
    let data = try Data(contentsOf: URL(fileURLWithPath: "\(metadataPath)/podcast.json"))
    return try JSONDecoder().decode(PodcastConfig.self, from: data)
  }

  func loadSeries() throws -> [SeriesMetadata] {
    let seriesData = try Data(
      contentsOf: URL(fileURLWithPath: "\(metadataPath)/series.json")
    )
    let seriesWrapper = try JSONDecoder()
      .decode([String: [SeriesMetadata]].self, from: seriesData)
    var allSeries = seriesWrapper["series"] ?? []

    // Load episodes for each series
    for i in 0..<allSeries.count {
      let episodesPath = "\(metadataPath)/episodes/\(allSeries[i].id).json"
      let episodesData = try Data(contentsOf: URL(fileURLWithPath: episodesPath))
      let episodesWrapper = try JSONDecoder()
        .decode([String: [Episode]].self, from: episodesData)
      allSeries[i].episodes = episodesWrapper["episodes"] ?? []
    }

    return allSeries
  }
}
