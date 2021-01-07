import Foundation

func readWorkoutFile(pers: Persister, filename: String) -> Workout {
  do {
    let tmpWorkout = try pers.read(filename: filename, as: Workout.self)
    return tmpWorkout
  } catch {
    return Workout()
  }
}

func exerciseToStr(exercise: Exercise) -> String {
  let note = (exercise.note ?? "").isEmpty ? "" : ("\n" + exercise.note!)
  return String(exercise.reps1) + " / " + String(exercise.reps2) + " / " + String(exercise.reps3) + " " + exercise.description + note
}

func exerciseToJsonStr(exercise: Exercise) -> String {
  return """
{
  "reps1": "\(String(exercise.reps1))",
  "reps2": "\(String(exercise.reps2))",
  "reps3": "\(String(exercise.reps3))",
  "description": "\(exercise.description)",
  "note": "\(exercise.note ?? "")"
}
"""
}

func workoutsToStr(pers: Persister) -> String {
  return pers.listFiles().map {
    let archWorkout = readWorkoutFile(pers: pers, filename: $0.lastPathComponent)
    let ts = Date(timeIntervalSince1970: archWorkout.updatedAt)
    return timestampToStr(ts: ts) +
    "\n" +
    "Duration: " + String(archWorkout.elTime) + " seconds" +
    "\n" +
    archWorkout.exercises.map { exer in
      return exerciseToStr(exercise: exer)
    }.joined(separator: "\n")
  }.joined(separator: "\n")
}

func workoutsToJsonStr(pers: Persister) -> String {
  return "{\n\"workouts\": [\n" + pers.listFiles().map {
    let archWorkout = readWorkoutFile(pers: pers, filename: $0.lastPathComponent)
    let ts = Date(timeIntervalSince1970: archWorkout.updatedAt)
    let exercisesStr = archWorkout.exercises.map { exer in
      return exerciseToJsonStr(exercise: exer)
    }.joined(separator: ",\n")
    return """
{
  "updatedAt": "\(timestampToStr(ts: ts))",
  "duration": "\(String(archWorkout.elTime)) seconds",
  "exercises": [
    \(exercisesStr)
  ]
}
"""
  }.joined(separator: ",\n") + "]\n}"
}

func workoutToJsonStr(pers: Persister, fileUrl: URL) -> String {
  let archWorkout = readWorkoutFile(pers: pers, filename: fileUrl.lastPathComponent)
  let ts = Date(timeIntervalSince1970: archWorkout.updatedAt)
  let exercisesStr = archWorkout.exercises.map { exer in
    return exerciseToJsonStr(exercise: exer)
  }.joined(separator: ",\n")
  return """
{
  "updatedAt": "\(timestampToStr(ts: ts))",
  "duration": "\(String(archWorkout.elTime)) seconds",
  "exercises": [
    \(exercisesStr)
  ]
}
"""
}


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
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "pull-ups"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "squats"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "dips"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "hinges"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "rows"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "push-ups"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "anti-extension"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "anti-rotation"))
    exercises.append(Exercise(reps1: 5, reps2: 5, reps3: 5, description: "extension"))
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
