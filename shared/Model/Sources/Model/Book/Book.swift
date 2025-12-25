import Foundation

// MARK: - Book

struct Book: Codable, Equatable {
  let id: BookID
  let title: String
  let authors: [Author]
  let publicationYear: Int
  let url: URL
  let publisher: Publisher
}

extension Book {
  static let allBooks: [Book] = []

  static let 叶嘉莹讲杜甫诗 = Book(
    id: .book1,
    title: "叶嘉莹讲杜甫诗",
    authors: [.叶嘉莹],
    publicationYear: 2018,
    url: URL(string: "https://book.douban.com/subject/30210723/")!,
    publisher: .中华书局
  )
}
