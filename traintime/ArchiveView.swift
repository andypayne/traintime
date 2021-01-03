import SwiftUI

func timestampToStr(ts: Date) -> String {
  let dateFormat = DateFormatter()
  dateFormat.timeZone = .current
  dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
  return dateFormat.string(from: ts)
}

struct ArchiveView: View {
  @State var pers: Persister = Persister()
  @State private var showingAlert = false

  var body: some View {
    ZStack {
      Theme.bgColor
        .ignoresSafeArea()
      VStack (alignment: .leading, spacing: 10) {
        Button(action: {
          let shareData = workoutsToJsonStr(pers: pers)
          let av = UIActivityViewController(activityItems: [shareData], applicationActivities: nil)
          UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }) {
          Image(systemName: ("square.and.arrow.up"))
              .font(.system(size: 24))
            .foregroundColor(Theme.activeCtrlColor)
        }

        ScrollView {
          VStack (alignment: .leading, spacing: 10) {
            ForEach(pers.listFiles(), id: \.self) { fn in
              let archWorkout = readWorkoutFiles(pers: pers, filename: fn.lastPathComponent)
              let ts = Date(timeIntervalSince1970: archWorkout.updatedAt)
              Text(timestampToStr(ts: ts))
                .font(.custom("SpaceMono-Bold", size: 24))
                .foregroundColor(Theme.activeCtrlColor)
              Button(action: {
                self.showingAlert = true
              }) {
                Image(systemName: ("trash"))
                    .font(.system(size: 24))
                  .foregroundColor(Theme.activeCtrlColor)
              }
              .alert(isPresented: $showingAlert, content: { Alert(title: Text("Delete this workout?"), primaryButton: .destructive(Text("Delete")) {
                  print("Deleting ", fn.lastPathComponent)
                  pers.removeFile(fileUrl: fn)
                },
                secondaryButton: .cancel()
              ) })
              Text("Duration: " + String(archWorkout.elTime) + " seconds")
                .font(.custom("SpaceMono-Bold", size: 18))
                .foregroundColor(Theme.activeCtrlColor)
              ForEach(archWorkout.exercises, id: \.self) { exercise in
                Text(exerciseToStr(exercise: exercise))
                  .font(.custom("SpaceMono-Bold", size: 18))
                  .foregroundColor(Theme.activeCtrlColor)
              }
            }
          }
        }
      }
    }
  }
}

struct ArchiveView_Previews: PreviewProvider {
  static var previews: some View {
    ArchiveView()
  }
}
