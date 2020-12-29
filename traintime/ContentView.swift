//
//  ContentView.swift
//  traintime
//
//  Created by Andy on 12/25/20.
//

import SwiftUI

struct ContentView: View {
  //@State private var
  @ObservedObject var st = SimpleTimer()
  @State private var playing = false
  @State private var paused = false
  @State private var resting = false
  @State var activeExerciseIdx = -1
  @State var pers: Persister = Persister()
  //@State private var workout: Workout = Workout()
  @ObservedObject var workout: Workout = Workout()

  var activeColor = Color(red: 0.25, green: 0.25, blue: 0.25, opacity: 1.0)
  var inactiveColor = Color(red: 0.75, green: 0.75, blue: 0.75, opacity: 1.0)
  var bgColor = Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0)
  var ctrlColor = Color(red: 0.25, green: 0.25, blue: 0.25, opacity: 1.0)

  var body: some View {
    ZStack {
      bgColor
        .ignoresSafeArea()
      VStack (spacing: 0) {
        HStack {
          Button(action: {
            if !self.playing || self.paused {
              self.st.startTimer()
              self.playing = true
              self.paused = false
            } else {
              self.paused = true
              self.st.pauseTimer()
            }
          }) {
            Image(systemName: (!self.playing || self.paused ? "play.fill" : "pause.fill"))
              .font(.system(size: 42))
              .foregroundColor(ctrlColor)
          }
          Button(action: {
            self.st.resetTimer()
            self.paused = false
            self.playing = false
          }) {
            Image(systemName: ("stop.fill"))
              .font(.system(size: 42))
              .foregroundColor(ctrlColor)
          }
          Button(action: {
            print("rest")
            self.resting = true
            self.workout.elTime = st.elTime
            pers.write(filename: pers.getFilename(), workout)
          }) {
            Image(systemName: ("circle.fill"))
              .font(.system(size: 42))
              .foregroundColor(ctrlColor)
          }
          /*
          Button(action: {
            print("rest")
            self.resting = true
            //let res = pers.read(filename: pers.getFilename())
            //print("Result: ", res)
`            self.workout.elTime = st.elTime
            pers.write(filename: pers.getFilename(), workout)
          }) {
            Image(systemName: ("circle.fill"))
              .font(.system(size: 42))
              .foregroundColor(ctrlColor)
          }
          Button(action: {
            do {
              //self.$workout = try pers.read(filename: pers.getFilename(), as: Workout.self)
              let tmpWorkout = try pers.read(filename: pers.getFilename(), as: Workout.self)
              //self.workout = tmpWorkout
              self.workout.elTime = tmpWorkout.elTime
              st.elTime = self.workout.elTime
              self.workout.updatedAt = tmpWorkout.updatedAt
              self.workout.exercises = tmpWorkout.exercises
            } catch {
              print("Caught error")
            }
          }) {
            Image(systemName: ("circle"))
              .font(.system(size: 42))
              .foregroundColor(ctrlColor)
          }
          */
        }
        ScrollView {
          VStack (spacing: 0) {
            HStack {
              Text(self.st.pad(v: self.st.h()))
                //.fontWeight(.bold)
                .font(.custom("SpaceMono-Bold", size: 108))
                .foregroundColor(self.playing ? activeColor : inactiveColor)
              Text("H")
                .font(.custom("SpaceMono-Bold", size: 36))
                .foregroundColor(activeColor)
                .padding(.top, 36.0)
            }
            HStack {
              Text(self.st.pad(v: self.st.m()))
                //.fontWeight(.bold)
                .font(.custom("SpaceMono-Bold", size: 108))
                .foregroundColor(self.playing ? activeColor : inactiveColor)
              Text("M")
                .font(.custom("SpaceMono-Bold", size: 36))
                .foregroundColor(activeColor)
                .padding(.top, 36.0)
            }
            HStack {
              Text(self.st.pad(v: self.st.s()))
                //.fontWeight(.bold)
                .font(.custom("SpaceMono-Bold", size: 108))
                .foregroundColor(self.playing ? activeColor : inactiveColor)
              Text("S")
                .font(.custom("SpaceMono-Bold", size: 36))
                .foregroundColor(activeColor)
                .padding(.top, 36.0)
            }

            VStack(alignment: .leading, spacing: 20) {
              Button(action: {
                activeExerciseIdx = 0
              }) {
                ExerciseView(workout: self.workout, exIdx: 0, isActive: activeExerciseIdx == 0, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 1
              }) {
                ExerciseView(workout: self.workout, exIdx: 1, isActive: activeExerciseIdx == 1, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 2
              }) {
                ExerciseView(workout: self.workout, exIdx: 2, isActive: activeExerciseIdx == 2, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 3
              }) {
                ExerciseView(workout: self.workout, exIdx: 3, isActive: activeExerciseIdx == 3, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 4
              }) {
                ExerciseView(workout: self.workout, exIdx: 4, isActive: activeExerciseIdx == 4, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 5
              }) {
                ExerciseView(workout: self.workout, exIdx: 5, isActive: activeExerciseIdx == 5, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 6
              }) {
                ExerciseView(workout: self.workout, exIdx: 6, isActive: activeExerciseIdx == 6, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 7
              }) {
                ExerciseView(workout: self.workout, exIdx: 7, isActive: activeExerciseIdx == 7, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
              Button(action: {
                activeExerciseIdx = 8
              }) {
                ExerciseView(workout: self.workout, exIdx: 8, isActive: activeExerciseIdx == 8, persister: pers, activeColor: activeColor, inactiveColor: inactiveColor)
              }
              .padding(.leading, 10)
            }
          }
        }
      }
    }.onAppear {
      do {
        let tmpWorkout = try pers.read(filename: pers.getFilename(), as: Workout.self)
        self.workout.elTime = tmpWorkout.elTime
        st.elTime = self.workout.elTime
        self.workout.updatedAt = tmpWorkout.updatedAt
        self.workout.exercises = tmpWorkout.exercises
      } catch {
        print("Caught error")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      
  }
}
