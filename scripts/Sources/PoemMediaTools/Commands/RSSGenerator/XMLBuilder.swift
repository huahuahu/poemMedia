import Foundation

class XMLBuilder {
  let podcast: PodcastConfig
  let releaseVersion: String
  let repoUrl = "https://github.com/huahuahu/poemMedia"

  init(podcast: PodcastConfig, releaseVersion: String = "v1.0.0") {
    self.podcast = podcast
    self.releaseVersion = releaseVersion
  }

  func buildFeed(
    title: String,
    description: String? = nil,
    episodes: [Episode],
    feedId: String? = nil
  ) -> String {
    let desc = description ?? podcast.description
    let feedUrl = feedId.map { _ in "\(repoUrl)/releases/download/\(releaseVersion)" } ?? ""

    var xml = """
    <?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0" \
    xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" \
    xmlns:content="http://purl.org/rss/1.0/modules/content/" \
    xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <title>\(xmlEscape(title))</title>
        <link>\(podcast.websiteUrl)</link>
        <language>\(podcast.language)</language>
        <description>\(xmlEscape(desc))</description>
        <lastBuildDate>\(formatRFC822Date(Date()))</lastBuildDate>
        <ttl>3600</ttl>

        <itunes:author>\(xmlEscape(podcast.author))</itunes:author>
        <itunes:summary>\(xmlEscape(desc))</itunes:summary>
        <itunes:explicit>\(podcast.explicit ? "yes" : "no")</itunes:explicit>
        <itunes:category text="\(podcast.category)">
    """

    if let subcategory = podcast.subcategory {
      xml += "\n      <itunes:category text=\"\(subcategory)\"/>"
    }
    xml += "\n    </itunes:category>"

    xml += """

        <itunes:owner>
          <itunes:name>\(xmlEscape(podcast.author))</itunes:name>
          <itunes:email>\(podcast.email)</itunes:email>
        </itunes:owner>

        <image>
          <url>\(podcast.websiteUrl)assets/podcast-cover.jpg</url>
          <title>\(xmlEscape(title))</title>
          <link>\(podcast.websiteUrl)</link>
        </image>

    """

    // Add items (episodes) in reverse order (newest first)
    for episode in episodes.sorted(by: { $0.episodeNumber > $1.episodeNumber }) {
      let audioUrl =
        "\(repoUrl)/releases/download/\(releaseVersion)/\(urlEncode(episode.id)).mp3"
      let pubDate = formatRFC822Date(parseISO8601(episode.pubDate))
      let durationStr = formatDuration(episode.duration)

      xml += """
          <item>
            <title>\(xmlEscape(episode.title))</title>
            <description>\(xmlEscape(episode.description))</description>
            <link>\(podcast.websiteUrl)</link>
            <guid isPermaLink="false">\(episode.id)</guid>
            <pubDate>\(pubDate)</pubDate>
            <enclosure url="\(audioUrl)" length="\(episode.fileSize)" type="audio/mpeg"/>
            <itunes:author>\(xmlEscape(podcast.author))</itunes:author>
            <itunes:duration>\(durationStr)</itunes:duration>
            <itunes:episode>\(episode.episodeNumber)</itunes:episode>
            <itunes:season>\(episode.season)</itunes:season>
            <itunes:episodeType>full</itunes:episodeType>
          </item>

      """
    }

    xml += """
      </channel>
    </rss>
    """

    return xml
  }

  // MARK: - Helper Methods

  private func xmlEscape(_ str: String) -> String {
    return str
      .replacingOccurrences(of: "&", with: "&amp;")
      .replacingOccurrences(of: "<", with: "&lt;")
      .replacingOccurrences(of: ">", with: "&gt;")
      .replacingOccurrences(of: "\"", with: "&quot;")
      .replacingOccurrences(of: "'", with: "&apos;")
  }

  private func urlEncode(_ str: String) -> String {
    let allowed = CharacterSet.urlPathAllowed
    return str.addingPercentEncoding(withAllowedCharacters: allowed) ?? str
  }

  private func formatDuration(_ seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let secs = seconds % 60

    if hours > 0 {
      return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    } else {
      return String(format: "%02d:%02d", minutes, secs)
    }
  }

  private func formatRFC822Date(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(abbreviation: "GMT")
    return formatter.string(from: date)
  }

  private func parseISO8601(_ dateString: String) -> Date {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter.date(from: dateString) ?? Date()
  }
}
