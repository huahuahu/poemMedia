import Foundation

// MARK: - Author

struct Author: Codable, Equatable {
  let id: AuthorID
  let name: String
  let birthTime: TimePoint
  let deathTime: TimePoint?
  let gender: Gender
  let url: URL?
}

// MARK: - Gender

enum Gender: String, Codable, Equatable {
  case male
  case female
  case other

  var displayString: String {
    switch self {
    case .male:
      "男"
    case .female:
      "女"
    case .other:
      "其他"
    }
  }
}

extension Author {
  static let allAuthors: [Author] = [
    .叶嘉莹,
  ]

  static let 叶嘉莹 = Author(
    id: .author1,
    name: "叶嘉莹",
    birthTime: .complete(date: DateComponents(
      calendar: Calendar(identifier: .gregorian),
      year: 1924,
      month: 7,
      day: 2
    )
    .date!),
    deathTime: .complete(date: DateComponents(
      calendar: Calendar(identifier: .gregorian),
      year: 2024,
      month: 11,
      day: 24
    )
    .date!),
    gender: .female,
    url: URL(string: "https://www.douban.com/personage/27564215/")
  )
}
