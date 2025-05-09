import SwiftUI

struct WorkoutDetailView: View {
    @EnvironmentObject private var dataManager: DataManager
    @State private var showingAddExercise = false
    
    let workout: WorkoutModel
    
    var body: some View {
        List {
            Section(header: Text("Details")) {
                HStack {
                    Text("Date")
                    Spacer()
                    Text(formattedDate)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Duration")
                    Spacer()
                    Text("\(workout.duration) minutes")
                        .foregroundColor(.secondary)
                }
                
                if let notes = workout.notes, !notes.isEmpty {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Notes")
                            .font(.headline)
                        Text(notes)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            Section(header: Text("Exercises")) {
                ForEach(workout.exerciseArray) { exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                        ExerciseRowView(exercise: exercise)
                    }
                }
                .onDelete(perform: deleteExercises)
                
                Button(action: {
                    showingAddExercise = true
                }) {
                    Label("Add Exercise", systemImage: "plus")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(workout.name)
        .sheet(isPresented: $showingAddExercise) {
            AddExerciseView(workout: workout)
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: workout.date)
    }
    
    private func deleteExercises(at offsets: IndexSet) {
        let exercises = workout.exerciseArray
        for index in offsets {
            dataManager.deleteExercise(exercises[index])
        }
    }
}

struct ExerciseRowView: View {
    let exercise: ExerciseModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(exercise.name)
                .font(.headline)
            
            HStack {
                Text("\(exercise.sets) sets")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Text("\(exercise.reps) reps")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Text("\(String(format: "%.1f", exercise.weight)) kg")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 5)
    }
} 