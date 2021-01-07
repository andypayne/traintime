import SwiftUI

struct ExerciseView: View {
  //@State var exercise: Exercise
  @ObservedObject var workout: Workout
  var exIdx: Int
  var isActive: Bool
  var persister: Persister
  static let maxReps = 10
  static let minReps = 1
  @State var addNote = false
  @State var exerNote = ""
  @State private var showingAlert = false

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(spacing: 10) {
        Button(action: {
          self.workout.exercises[exIdx].reps1 = (self.workout.exercises[exIdx].reps1 >= ExerciseView.maxReps ? ExerciseView.minReps : 1 + self.workout.exercises[exIdx].reps1)
          self.persister.write(filename: self.persister.getDefaultFilename(), self.workout)
        }) {
          Text(String(self.workout.exercises[exIdx].reps1))
            .font(.custom("SpaceMono-Bold", size: 24))
            .foregroundColor(Theme.activeCtrlColor)
        }
        Text("/")
          .font(.custom("SpaceMono-Bold", size: 24))
          .foregroundColor(Theme.activeCtrlColor)
        Button(action: {
          self.workout.exercises[exIdx].reps2 = (self.workout.exercises[exIdx].reps2 >= ExerciseView.maxReps ? ExerciseView.minReps : 1 + self.workout.exercises[exIdx].reps2)
          self.persister.write(filename: self.persister.getDefaultFilename(), self.workout)
        }) {
          Text(String(self.workout.exercises[exIdx].reps2))
            .font(.custom("SpaceMono-Bold", size: 24))
            .foregroundColor(Theme.activeCtrlColor)
        }
        Text("/")
          .font(.custom("SpaceMono-Bold", size: 24))
          .foregroundColor(Theme.activeCtrlColor)
        Button(action: {
          self.workout.exercises[exIdx].reps3 = (self.workout.exercises[exIdx].reps3 >= ExerciseView.maxReps ? ExerciseView.minReps : 1 + self.workout.exercises[exIdx].reps3)
          self.persister.write(filename: self.persister.getDefaultFilename(), self.workout)
        }) {
          Text(String(self.workout.exercises[exIdx].reps3))
            .font(.custom("SpaceMono-Bold", size: 24))
            .foregroundColor(Theme.activeCtrlColor)
        }
        Text(self.workout.exercises[exIdx].description)
          .font(.custom("SpaceMono-Bold", size: 24))
          .foregroundColor(Theme.activeCtrlColor)
      }
      .padding(.top, 5)
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
      .background(self.isActive ? Theme.highlightedBgColor : Theme.bgColor)
      HStack(spacing: 10) {
        Button(action: {
          addNote = true
        }) {
          Image(systemName: ("square.and.pencil"))
            .font(.system(size: 24))
            .foregroundColor(Theme.activeCtrlColor)
        }
        if addNote {
          Button(action: {
            self.showingAlert = true
          }) {
            Image(systemName: ("minus.circle"))
              .font(.system(size: 24))
              .foregroundColor(Theme.activeCtrlColor)
          }
          .alert(isPresented: $showingAlert, content: { Alert(title: Text("Delete this note?"), primaryButton: .destructive(Text("Delete")) {
              print("Deleting: ", self.exerNote)
              addNote = false
              self.exerNote = ""
            },
            secondaryButton: .cancel()
          ) })
        } else {
          EmptyView()
        }
      }.padding(.top, 5)
      if addNote {
        TextField("add a note",
          text: self.$exerNote,
          onEditingChanged: { _ in
            // nothing for now
          },
          onCommit: {
            self.workout.exercises[exIdx].note = self.exerNote
            self.persister.write(filename: self.persister.getDefaultFilename(), self.workout)
          })
        .font(.custom("SpaceMono-Bold", size: 24))
        .foregroundColor(Theme.activeCtrlColor)
      } else {
        EmptyView()
      }
    }.padding(.top, 20)
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
