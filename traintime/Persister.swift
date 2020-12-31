import Foundation

extension FileManager {
  func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
    let documentsURL = urls(for: directory, in: .userDomainMask)[0]
    let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
    return fileURLs
  }
}

class Persister: ObservableObject {
  let fileManager: FileManager
  @Published var filename: String

  init(fileManager: FileManager = .default) {
    self.fileManager = fileManager
    self.filename = "current_train_log.json"
  }

  private func fileUrl(filename: String) -> URL? {
    guard let url = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    return url.appendingPathComponent(filename)
  }

  func write<T: Encodable>(filename: String, _ encData: T) {
    guard let url = self.fileUrl(filename: filename) else {
      print("Error - failed to create a URL")
      return
    }
    if self.fileManager.fileExists(atPath: url.absoluteString) {
      print("Error - the file exists")
      return
    }
    do {
      let encoder = JSONEncoder()
      let encodedData = try encoder.encode(encData)
      FileManager.default.createFile(atPath: url.path, contents: encodedData, attributes: nil)
    } catch {
      print("Error - failed to write data to file")
      return
    }
  }

  func getDefaultFilename() -> String {
    return self.filename
  }

  func getArchiveFilename() -> String {
    let ts = Date().timeIntervalSince1970
    let fn = "train_log_" + String(ts) + ".json"
    return fn
  }

  func read<T: Decodable>(filename: String, as type: T.Type) throws -> T {
    guard let url = self.fileUrl(filename: filename) else {
      print("Error - failed to create a URL")
      fatalError("Failed to create a URL")
    }
    guard self.fileManager.fileExists(atPath: url.path) else {
      print("Error - the file does not exist")
      let decoder = JSONDecoder()
      let decData = try decoder.decode(type, from: Data())
      return decData
    }
    if let encData = FileManager.default.contents(atPath: url.path) {
      let decoder = JSONDecoder()
      do {
        let decData = try decoder.decode(type, from: encData)
        return decData
      } catch {
        print("Error - failed to decode data")
        fatalError("Failed to decode data")
      }
    } else {
      print("Error - file not found")
      fatalError("File not found")
    }
  }

  func listFiles() -> [URL] {
    let files = self.fileManager.urls(for: .documentDirectory)
    return files?.filter {
      $0.lastPathComponent.hasPrefix("train_log_")
    } ?? []
  }

  func listFilenames() -> [String] {
    let files = self.fileManager.urls(for: .documentDirectory)
    return files?.filter {
      $0.lastPathComponent.hasPrefix("train_log_")
    }.map { $0.absoluteString } ?? []
  }
}
