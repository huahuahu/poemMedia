import Foundation

// MARK: - MediaType

enum MediaType: String, Codable, Equatable {
  case image
  case video
  case audio
}

// MARK: - ImageFileType

enum ImageFileType: String, Codable, Equatable {
  case jpg
  case png
  case gif
}

// MARK: - AudioFileType

enum AudioFileType: String, Codable, Equatable {
  case mp3
  case aac
}

// MARK: - VideoFileType

enum VideoFileType: String, Codable, Equatable {
  case mp4
  case mov
}

// MARK: - AudioID

enum AudioID: String, CaseIterable, Equatable, Codable {
  case audio1 = "D4F7H2J9K1"
  case audio2 = "E5G8I3L0M2"
  case audio3 = "F6H9J4N1O3"
  case audio4 = "A7B8C9D0E1"
  case audio5 = "F2G3H4I5J6"
  case audio6 = "K7L8M9N0O1"
  case audio11 = "J2K3L4M5N6"
  case audio12 = "O7P8Q9R0S1"
  case audio13 = "T2U3V4W5X6"
  case audio14 = "Y7Z8A9B0C1"
  case audio15 = "D2E3F4G5H6"
  case audio16 = "I7J8K9L0M1"
  case audio17 = "N2O3P4Q5R6"
  case audio18 = "S7T8U9V0W1"
  case audio19 = "X2Y3Z4A5B6"
  case audio20 = "C7D8E9F0G1"
  case audio21 = "H2I3J4K5L6"
  case audio22 = "M7N8O9P0Q1"
  case audio23 = "R2S3T4U5V6"
  case audio24 = "W7X8Y9Z0A1"
  case audio25 = "B2C3D4E5F6"
  case audio26 = "G7H8I9J0K1"
  case audio27 = "L2M3N4O5P6"
  case audio28 = "Q7R8S9T0U1"
  case audio29 = "V2W3X4Y5Z6"
  case audio30 = "A7B8C9D0E1"
  case audio31 = "F2G3H4I5J6"
  case audio32 = "K7L8M9N0O1"
  case audio33 = "P2Q3R4S5T6"
  case audio34 = "U7V8W9X0Y1"
  case audio35 = "Z2A3B4C5D6"
  case audio36 = "E7F8G9H0I1"
  case audio37 = "J2K3L4M5N6"
  case audio38 = "O7P8Q9R0S1"
  case audio39 = "T2U3V4W5X6"
  case audio40 = "Y7Z8A9B0C1"
  case audio41 = "D2E3F4G5H6"
  case audio42 = "I7J8K9L0M1"
  case audio43 = "N2O3P4Q5R6"
  case audio44 = "S7T8U9V0W1"
  case audio45 = "X2Y3Z4A5B6"
  case audio46 = "C7D8E9F0G1"
  case audio47 = "H2I3J4K5L6"
  case audio48 = "M7N8O9P0Q1"
  case audio49 = "R2S3T4U5V6"
  case audio50 = "W7X8Y9Z0A1"
  case audio51 = "B2C3D4E5F6"
  case audio52 = "G7H8I9J0K1"
  case audio53 = "L2M3N4O5P6"
  case audio54 = "Q7R8S9T0U1"
  case audio55 = "V2W3X4Y5Z6"
  case audio56 = "A8B9C0D1E2"
  case audio57 = "F3G4H5I6J7"
  case audio58 = "K8L9M0N1O2"
  case audio59 = "P3Q4R5S6T7"
  case audio60 = "U8V9W0X1Y2"
  case audio61 = "Z3A4B5C6D7"
  case audio62 = "E8F9G0H1I2"
  case audio63 = "J3K4L5M6N7"
  case audio64 = "O8P9Q0R1S2"
  case audio65 = "T3U4V5W6X7"
  case audio66 = "Y8Z9A0B1C2"
  case audio67 = "D3E4F5G6H7"
  case audio68 = "I8J9K0L1M2"
  case audio69 = "N3O4P5Q6R7"
  case audio70 = "S8T9U0V1W2"
  case audio71 = "X3Y4Z5A6B7"
  case audio72 = "C8D9E0F1G2"
  case audio73 = "H3I4J5K6L7"
  case audio74 = "M8N9O0P1Q2"
  case audio75 = "R3S4T5U6V7"
  case audio76 = "W8X9Y0Z1A2"
  case audio77 = "B3C4D5E6F7"
  case audio78 = "G8H9I0J1K2"
  case audio79 = "L3M4N5O6P7"
  case audio80 = "Q8R9S0T1U2"
  case audio81 = "V3W4X5Y6Z7"
  case audio82 = "A8B9C0D1E2"
  case audio83 = "F3G4H5I6J7"
  case audio84 = "K8L9M0N1O2"
  case audio85 = "P3Q4R5S6T7"
  case audio86 = "U8V9W0X1Y2"
  case audio87 = "Z3A4B5C6D7"
  case audio88 = "E8F9G0H1I2"
  case audio89 = "J3K4L5M6N7"
  case audio90 = "O8P9Q0R1S2"
  case audio91 = "T3U4V5W6X7"
  case audio92 = "Y8Z9A0B1C2"
  case audio93 = "D3E4F5G6H7"
  case audio94 = "I8J9K0L1M2"
  case audio95 = "N3O4P5Q6R7"
  case audio96 = "S8T9U0V1W2"
  case audio97 = "X3Y4Z5A6B7"
  case audio98 = "C8D9E0F1G2"
  case audio99 = "H3I4J5K6L7"
  case audio100 = "M8N9O0P1Q2"
  case audio101 = "R3S4T5U6V7"
  case audio102 = "W8X9Y0Z1A2"
  case audio103 = "B3C4D5E6F7"
}

// MARK: - ImageID

enum ImageID: String, CaseIterable, Equatable, Codable {
  case image1 = "G1I4K7M0N2"
  case image2 = "H2J5L8N1O3"
  case image3 = "I3K6M9O2P4"
  case image4 = "J4L7N0P3Q5"
  case image5 = "K5M8O1Q4R6"
  case image6 = "L6N9P2R5S7"
  case image7 = "M7O0Q3S6T8"
  case image8 = "N8P1R4T7U9"
  case image9 = "O9Q2S5U8V0"
  case image10 = "P0R3T6V9W1"
  case image11 = "Q1S4U7W0X2"
  case image12 = "R2T5V8X1Y3"
  case image13 = "S3U6W9Y2Z4"
  case image14 = "T4V7X0Z3A5"
  case image15 = "U5W8Y1A4B6"
  case image16 = "V6X9Z2B5C7"
  case image17 = "W7Y0A3C6D8"
  case image18 = "X8Z1B4D7E9"
  case image19 = "Y9A2C5E8F0"
  case image20 = "Z0B3D6F9G1"
  case image21 = "A1C4E7G0H2"
  case image22 = "B2D5F8H1I3"
  case image23 = "C3E6G9I2J4"
  case image24 = "D4F7H0J3K5"
  case image25 = "E5G8I1K4L6"
  case image26 = "F6H9J2L5M7"
  case image27 = "G7I0K3M6N8"
  case image28 = "H8J1L4N7O9"
  case image29 = "I9K2M5O8P0"
  case image30 = "J0L3N6P9Q1"
  case image31 = "K1M4O7Q0R2"
  case image32 = "L2N5P8R1S3"
  case image33 = "M3O6Q9S2T4"
  case image34 = "N4P7R0T3U5"
  case image35 = "O5Q8S1U4V6"
  case image36 = "P6R9T2V5W7"
  case image37 = "Q7S0U3W6X8"
  case image38 = "R8T1V4X7Y9"
  case image39 = "S9U2W5Y8Z0"
  case image40 = "T0V3X6Z9A1"
  case image41 = "U1W4Y7A0B2"
  case image42 = "V2X5Z8B1C3"
  case image43 = "W3Y6A9C2D4"
  case image44 = "X4Z7B0D3E5"
  case image45 = "Y5A8C1E4F6"
  case image46 = "Z6B9D2F5G7"
  case image47 = "A7C0E3G6H8"
  case image48 = "B8D1F4H7I9"
  case image49 = "C9E2G5I8J0"
  case image50 = "D0F3H6J9K1"
  case image51 = "E1G4I7K0L2"
  case image52 = "F2H5J8L1M3"
  case image53 = "G3I6K9M2N4"
  case image54 = "H4J7L0N3O5"
  case image55 = "I5K8M1O4P6"
  case image56 = "J6L9N2P5Q7"
  case image57 = "K7M0O3Q6R8"
  case image58 = "L8N1P4R7S9"
  case image59 = "M9O2Q5S8T0"
  case image60 = "N0P3R6T9U1"
  case image61 = "O1Q4S7U0V2"
  case image62 = "P2R5T8V1W3"
  case image63 = "Q3S6U9W2X4"
  case image64 = "R4T7V0X3Y5"
  case image65 = "S5U8W1Y4Z6"
  case image66 = "T6V9X2Z5A7"
  case image67 = "U7W0Y3A6B8"
  case image68 = "V8X1Z4B7C9"
  case image69 = "W9Y2A5C8D0"
  case image70 = "X0Z3B6D9E1"
  case image71 = "Y1A4C7E0F2"
  case image72 = "Z2B5D8F1G3"
  case image73 = "A3C6E9G2H4"
  case image74 = "B4D7F0H3I5"
  case image75 = "C5E8G1I4J6"
  case image76 = "D6F9H2J5K7"
  case image77 = "E7G0I3K6L8"
  case image78 = "F8H1J4L7M9"
  case image79 = "G9I2K5M8N0"
  case image80 = "H0J3L6N9O1"
  case image81 = "I1K4M7O0P2"
  case image82 = "J2L5N8P1Q3"
  case image83 = "K3M6O9Q2R4"
  case image84 = "L4N7P0R3S5"
  case image85 = "M5O8Q1S4T6"
  case image86 = "N6P9R2T5U7"
  case image87 = "O7Q0S3U6V8"
  case image88 = "P8R1T4V7W9"
  case image89 = "Q9S2U5W8X0"
  case image90 = "R0T3V6X9Y1"
  case image91 = "S1U4W7Y0Z2"
  case image92 = "T2V5X8Z1A3"
  case image93 = "U3W6Y9A2B4"
  case image94 = "V4X7Z0B3C5"
  case image95 = "W5Y8A1C4D6"
  case image96 = "X6Z9B2D5E7"
  case image97 = "Y7A0C3E6F8"
  case image98 = "Z8B1D4F7G9"
  case image99 = "A9C2E5G8H0"
  case image100 = "B0D3F6H9I1"
  case image101 = "C1E4G7I0J2"
  case image102 = "D2F5H8J1K3"
  case image103 = "E3G6I9K2L4"
}

// MARK: - AudioMedia

struct AudioMedia: Codable, Equatable {
  let id: AudioID
  let fileType: audioFileType
  let localURL: URL
  let remoteURL: URL?
  let hashValue: String?
}

extension AudioMedia {
  static let 杜甫早期生活及诗作 = AudioMedia(
    id: .audio1,
    fileType: .mp3,
    localURL: URL(fileURLWithPath: "data/叶嘉莹说杜甫/1-早期生活及诗作.mp3"),
    remoteURL: nil,
    hashValue: nil
  )

  static let 杜甫在长安求仕时期生活及诗作 = AudioMedia(
    id: .audio2,
    fileType: .mp3,
    localURL: URL(fileURLWithPath: "data/叶嘉莹说杜甫/2-在长安求仕时期生活及诗作.mp3"),
    remoteURL: nil,
    hashValue: nil
  )

  static let 杜甫安史之乱将起时的一篇名作 = AudioMedia(
    id: .audio3,
    fileType: .mp3,
    localURL: URL(fileURLWithPath: "data/叶嘉莹说杜甫/3-安史之乱将起时的一篇名作.mp3"),
    remoteURL: nil,
    hashValue: nil
  )

  static let 杜甫身陷长安时的作品 = AudioMedia(
    id: .audio4,
    fileType: .mp3,
    localURL: URL(fileURLWithPath: "data/叶嘉莹说杜甫/4-身陷长安时的作品.mp3"),
    remoteURL: nil,
    hashValue: nil
  )

  static let 杜甫长安收复后官拾遗时的作品 = AudioMedia(
    id: .audio5,
    fileType: .mp3,
    localURL: URL(fileURLWithPath: "data/叶嘉莹说杜甫/6-长安收复后官拾遗时的作品.mp3"),
    remoteURL: nil,
    hashValue: nil
  )

  static let 杜甫的一组名诗 = AudioMedia(
    id: .audio6,
    fileType: .mp3,
    localURL: URL(fileURLWithPath: "data/叶嘉莹说杜甫/9-杜甫的一组名诗.mp3"),
    remoteURL: nil,
    hashValue: nil
  )
}
