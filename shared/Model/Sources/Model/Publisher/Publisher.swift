import Foundation

// MARK: - Publisher

// 出版社
struct Publisher: Codable, Equatable {
  let id: PublisherID
  let name: String
  let url: URL?
}

extension Publisher {
  static let allPublishers: [Publisher] = [
    .中华书局,
  ]

  static let 中华书局 = Publisher(
    id: .publisher1,
    name: "中华书局",
    url: URL(string: "http://www.zhbc.com.cn/zhsj/fg/home/home.html")
  )
}
