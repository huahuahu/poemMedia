import Foundation

// MARK: - TimePoint

/// 表示时间点信息的枚举类型，可用于记录出生、死亡等各种历史时间
enum TimePoint: Codable, Equatable {
  /// 不知道具体时间
  case unknown

  /// 还未发生（例如：人物还在世，事件还未发生）
  case notYet

  /// 知道时间但不确定，包含一个大致的时间和不确定程度的描述
  case uncertain(approximateDate: Date, note: String?)

  /// 只知道年份，不知道具体月份和日期
  case yearOnly(year: Int)

  /// 知道完整的年月日
  case complete(date: Date)

  // MARK: - Computed Properties

  /// 获取最接近的日期表示（如果有的话）
  var approximateDate: Date? {
    switch self {
    case .unknown, .notYet:
      return nil
    case let .uncertain(date, _):
      return date
    case let .yearOnly(year):
      // 返回该年份的1月1日
      var components = DateComponents()
      components.year = year
      components.month = 1
      components.day = 1
      return Calendar.current.date(from: components)
    case let .complete(date):
      return date
    }
  }

  /// 判断是否有确切的时间信息
  var hasDefiniteDate: Bool {
    switch self {
    case .unknown, .notYet:
      false
    case .uncertain, .yearOnly, .complete:
      true
    }
  }

  // MARK: - Display

  /// 格式化显示的字符串
  func displayString(dateFormatter: DateFormatter? = nil) -> String {
    let formatter = dateFormatter ?? {
      let f = DateFormatter()
      f.dateStyle = .medium
      return f
    }()

    switch self {
    case .unknown:
      return "不详"
    case .notYet:
      return "在世"
    case let .uncertain(date, note):
      let dateStr = formatter.string(from: date)
      if let note {
        return "\(dateStr)（约，\(note)）"
      } else {
        return "\(dateStr)（约）"
      }
    case let .yearOnly(year):
      return "\(year)年"
    case let .complete(date):
      return formatter.string(from: date)
    }
  }
}

// MARK: - Codable Implementation

extension TimePoint {
  enum CodingKeys: String, CodingKey {
    case type
    case approximateDate
    case note
    case year
    case date
  }

  enum EventType: String, Codable {
    case unknown
    case notYet
    case uncertain
    case yearOnly
    case complete
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(EventType.self, forKey: .type)

    switch type {
    case .unknown:
      self = .unknown
    case .notYet:
      self = .notYet
    case .uncertain:
      let date = try container.decode(Date.self, forKey: .approximateDate)
      let note = try container.decodeIfPresent(String.self, forKey: .note)
      self = .uncertain(approximateDate: date, note: note)
    case .yearOnly:
      let year = try container.decode(Int.self, forKey: .year)
      self = .yearOnly(year: year)
    case .complete:
      let date = try container.decode(Date.self, forKey: .date)
      self = .complete(date: date)
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    switch self {
    case .unknown:
      try container.encode(EventType.unknown, forKey: .type)
    case .notYet:
      try container.encode(EventType.notYet, forKey: .type)
    case let .uncertain(date, note):
      try container.encode(EventType.uncertain, forKey: .type)
      try container.encode(date, forKey: .approximateDate)
      try container.encodeIfPresent(note, forKey: .note)
    case let .yearOnly(year):
      try container.encode(EventType.yearOnly, forKey: .type)
      try container.encode(year, forKey: .year)
    case let .complete(date):
      try container.encode(EventType.complete, forKey: .type)
      try container.encode(date, forKey: .date)
    }
  }
}
