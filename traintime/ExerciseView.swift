//
//  ExerciseView.swift
//  traintime
//
//  Created by Andy on 12/26/20.
//

import SwiftUI

struct ExerciseView: View {
  //@State var exercise: Exercise
  @ObservedObject var workout: Workout
  var exIdx: Int
  var isActive: Bool
  var persister: Persister
  var activeColor: Color
  var inactiveColor: Color
  var activeExerciseColor = Color(red: 0.75, green: 0.75, blue: 0.75, opacity: 1.0)
//  @State var activeExercise = false
  static let maxReps = 10
  static let minReps = 1

  var body: some View {
    HStack(spacing: 10) {
      Button(action: {
        self.workout.exercises[exIdx].reps1 = (self.workout.exercises[exIdx].reps1 >= ExerciseView.maxReps ? ExerciseView.minReps : 1 + self.workout.exercises[exIdx].reps1)
        self.persister.write(filename: self.persister.getFilename(), self.workout)
      }) {
        Text(String(self.workout.exercises[exIdx].reps1))
          .font(.custom("SpaceMono-Bold", size: 24))
          .foregroundColor(activeColor)
      }
      Text("/")
        .font(.custom("SpaceMono-Bold", size: 24))
        .foregroundColor(activeColor)
      Button(action: {
        self.workout.exercises[exIdx].reps2 = (self.workout.exercises[exIdx].reps2 >= ExerciseView.maxReps ? ExerciseView.minReps : 1 + self.workout.exercises[exIdx].reps2)
        self.persister.write(filename: self.persister.getFilename(), self.workout)
      }) {
        Text(String(self.workout.exercises[exIdx].reps2))
          .font(.custom("SpaceMono-Bold", size: 24))
          .foregroundColor(activeColor)
      }
      Text("/")
        .font(.custom("SpaceMono-Bold", size: 24))
        .foregroundColor(activeColor)
      Button(action: {
        self.workout.exercises[exIdx].reps3 = (self.workout.exercises[exIdx].reps3 >= ExerciseView.maxReps ? ExerciseView.minReps : 1 + self.workout.exercises[exIdx].reps3)
        self.persister.write(filename: self.persister.getFilename(), self.workout)
      }) {
        Text(String(self.workout.exercises[exIdx].reps3))
          .font(.custom("SpaceMono-Bold", size: 24))
          .foregroundColor(activeColor)
      }
      /*
      Button(action: {
        self.activeExercise = !self.activeExercise
      }) {
      */
        Text(self.workout.exercises[exIdx].description)
          .font(.custom("SpaceMono-Bold", size: 24))
          .foregroundColor(activeColor)
//      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    .background(self.isActive ? activeExerciseColor : Color.white)
  }
}

/*
struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(exercise: Exercise(reps1: 1, reps2: 2, reps3: 3, description: "pull-ups"), activeColor: Color(red: 0.25, green: 0.25, blue: 0.25, opacity: 1.0),
                 inactiveColor: Color(red: 0.75, green: 0.75, blue: 0.75, opacity: 1.0))
  }
}
*/
