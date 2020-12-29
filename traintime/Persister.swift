//
//  Persister.swift
//  traintime
//
//  Created by Andy on 12/27/20.
//

import Foundation

class Persister: ObservableObject {
  let fileManager: FileManager
  //@Published var perData: Data?
  @Published var filename: String

  init(fileManager: FileManager = .default) {
    self.fileManager = fileManager
    //self.perData = "This is some data to store!".data(using: .utf8)
    //print(String(data:self.perData!, encoding: .utf8)!)
    //let ts = NSDate().timeIntervalSince1970
    //let ts = Date().timeIntervalSince1970
    //print("epoch: ", String(ts))
    //let fn = "train_log_" + String(ts)
    //print("filename: ", fn)
    //self.write(filename: fn)
    //self.filename = "train_log_" + String(ts)
    //self.write(filename: self.filename)
    self.filename = "current_train_log.json"
  }

  private func fileUrl(filename: String) -> URL? {
    guard let url = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    return url.appendingPathComponent(filename)
  }

  /*
  func writeOLD(filename: String) {
    guard let url = self.fileUrl(filename: filename) else {
      print("Error - failed to create a URL")
      return
    }
    print("url: ", url.absoluteString)
    if self.fileManager.fileExists(atPath: url.absoluteString) {
      print("Error - the file exists")
      return
    }
    do {
      print("perData = ", String(data:self.perData!, encoding: .utf8)!)
      try self.perData!.write(to: url)
      print("Wrote data to file")
    } catch {
      print("Error - failed to write data to file")
      return
    }
  }
  */

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

  func getFilename() -> String {
    return self.filename
  }

  func read<T: Decodable>(filename: String, as type: T.Type) throws -> T {
    guard let url = self.fileUrl(filename: filename) else {
      print("Error - failed to create a URL")
      fatalError("Failed to create a URL")
    }
    guard self.fileManager.fileExists(atPath: url.path) else {
      print("Error - the file does not exist")
      fatalError("The file does not exist")
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
}
