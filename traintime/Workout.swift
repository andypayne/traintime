//
//  Workout.swift
//  traintime
//
//  Created by Andy on 12/27/20.
//

import Foundation

class Workout: ObservableObject, Codable {
  enum CodingKeys: CodingKey {
      case ver, updatedAt, elTime, exercises
  }

  @Published var ver: String
  @Published var updatedAt: Double
  @Published var elTime: Int
  @Published var exercises = [Exercise]()

  init() {
    ver = "0.1.1"
    updatedAt = Date().timeIntervalSince1970
    elTime = 0
    exercises.append(Exercise(reps1: 1, reps2: 2, reps3: 1, description: "pull-ups"))
    exercises.append(Exercise(reps1: 4, reps2: 2, reps3: 3, description: "squats"))
    exercises.append(Exercise(reps1: 1, reps2: 5, reps3: 3, description: "dips"))
    exercises.append(Exercise(reps1: 1, reps2: 2, reps3: 6, description: "single leg RDL"))
    exercises.append(Exercise(reps1: 7, reps2: 2, reps3: 3, description: "rows"))
    exercises.append(Exercise(reps1: 1, reps2: 8, reps3: 3, description: "push-ups"))
    exercises.append(Exercise(reps1: 1, reps2: 2, reps3: 9, description: "anti-extension"))
    exercises.append(Exercise(reps1: 1, reps2: 2, reps3: 3, description: "anti-rotation"))
    exercises.append(Exercise(reps1: 1, reps2: 2, reps3: 3, description: "extension"))
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    ver = try container.decode(String.self, forKey: .ver)
    updatedAt = try container.decode(Double.self, forKey: .updatedAt)
    elTime = try container.decode(Int.self, forKey: .elTime)
    exercises = try container.decode([Exercise].self, forKey: .exercises)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(ver, forKey: .ver)
    try container.encode(updatedAt, forKey: .updatedAt)
    try container.encode(elTime, forKey: .elTime)
    try container.encode(exercises, forKey: .exercises)
  }

}
