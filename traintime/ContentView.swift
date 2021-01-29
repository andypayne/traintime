import SwiftUI

struct ContentView: View {
  @ObservedObject var st: SimpleTimer
  @State private var playing = false
  @State private var paused = false
  @State private var resting = false
  @State var activeExerciseIdx = -1
  @State var pers: Persister = Persister()
  @ObservedObject var workout: Workout = Workout()
  @State var isNavHidden = true

  var body: some View {
    NavigationView {
      ZStack {
        Theme.bgColor
          .ignoresSafeArea()
        VStack (spacing: 0) {
          HStack {
            Button(action: {
              if !self.playing || self.paused {
                self.st.startTimer()
                self.playing = true
                self.paused = false
                SleepControl.disableSleep()
              } else {
                self.paused = true
                self.st.pauseTimer()
                SleepControl.enableSleep()
              }
            }) {
              Image(systemName: (!self.playing || self.paused ? "play.fill" : "pause.fill"))
                .font(.system(size: 42))
                .foregroundColor(Theme.activeCtrlColor)
            }
            Button(action: {
              if self.paused || !self.playing {
                self.workout.elTime = st.elTime
                self.workout.updatedAt = Date().timeIntervalSince1970
                pers.write(filename: pers.getArchiveFilename(), workout)
                self.workout.clearNotes()
                pers.write(filename: pers.getDefaultFilename(), self.workout)
                self.st.resetTimer()
                self.workout.elTime = st.elTime
              }
            }) {
              Image(systemName: ("arrow.down.circle.fill"))
                .font(.system(size: 42))
                .foregroundColor((self.paused || !self.playing) ? Theme.activeCtrlColor : Theme.inactiveCtrlColor)
            }
            NavigationLink(destination: ArchiveView().onAppear {
              self.isNavHidden = false
            }.onDisappear {
              self.isNavHidden = true
            }
            ) {
              Image(systemName: ("doc.text"))
                .font(.system(size: 42))
                .foregroundColor(Theme.activeCtrlColor)
            }
          }

          VStack (spacing: 0) {
            HStack {
              Text(self.st.pad(v: self.st.h()))
                .font(.custom("SpaceMono-Bold", size: 108))
                .foregroundColor(self.playing ? Theme.activeCtrlColor : Theme.inactiveCtrlColor)
                .padding(.vertical, -33)
              Text("H")
                .font(.custom("SpaceMono-Bold", size: 36))
                .foregroundColor(Theme.activeCtrlColor)
                .padding(0)
            }.padding(0)
            HStack {
              Text(self.st.pad(v: self.st.m()))
                .font(.custom("SpaceMono-Bold", size: 108))
                .foregroundColor(self.playing ? Theme.activeCtrlColor : Theme.inactiveCtrlColor)
                .padding(.vertical, -33)
              Text("M")
                .font(.custom("SpaceMono-Bold", size: 36))
                .foregroundColor(Theme.activeCtrlColor)
                .padding(0)
            }.padding(0)
            HStack {
              Text(self.st.pad(v: self.st.s()))
                .font(.custom("SpaceMono-Bold", size: 108))
                .foregroundColor(self.playing ? Theme.activeCtrlColor : Theme.inactiveCtrlColor)
                .padding(.vertical, -33)
              Text("S")
                .font(.custom("SpaceMono-Bold", size: 36))
                .foregroundColor(Theme.activeCtrlColor)
                .padding(0)
            }.padding(0)

            ScrollView {
              VStack(alignment: .leading, spacing: 18) {
                Button(action: {
                  activeExerciseIdx = 0
                }) {
                  ExerciseView(workout: self.workout, exIdx: 0, isActive: activeExerciseIdx == 0, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 1
                }) {
                  ExerciseView(workout: self.workout, exIdx: 1, isActive: activeExerciseIdx == 1, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 2
                }) {
                  ExerciseView(workout: self.workout, exIdx: 2, isActive: activeExerciseIdx == 2, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 3
                }) {
                  ExerciseView(workout: self.workout, exIdx: 3, isActive: activeExerciseIdx == 3, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 4
                }) {
                  ExerciseView(workout: self.workout, exIdx: 4, isActive: activeExerciseIdx == 4, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 5
                }) {
                  ExerciseView(workout: self.workout, exIdx: 5, isActive: activeExerciseIdx == 5, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 6
                }) {
                  ExerciseView(workout: self.workout, exIdx: 6, isActive: activeExerciseIdx == 6, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 7
                }) {
                  ExerciseView(workout: self.workout, exIdx: 7, isActive: activeExerciseIdx == 7, persister: pers)
                }
                .padding(.leading, 10)
                Button(action: {
                  activeExerciseIdx = 8
                }) {
                  ExerciseView(workout: self.workout, exIdx: 8, isActive: activeExerciseIdx == 8, persister: pers)
                }
                .padding(.leading, 10)
              }
            }
            .padding(.vertical, 0.0)
          }
        }

      }.onAppear {
        do {
          let tmpWorkout = try pers.read(filename: pers.getDefaultFilename(), as: Workout.self)
          self.workout.elTime = tmpWorkout.elTime
          self.workout.updatedAt = tmpWorkout.updatedAt
          self.workout.exercises = tmpWorkout.exercises
        } catch {
          print("Caught error")
        }
      }
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(self.isNavHidden)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(st: SimpleTimer())
      
  }
}
