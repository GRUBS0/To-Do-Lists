import SwiftUI

struct ContentView: View {

    @StateObject private var notebook = AssignmentList()
    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {

                    // Top header
                    headerView

                    // Assignment list
                    List {
                        ForEach(notebook.items) { assignment in
                            assignmentCard(assignment)
                                .listRowBackground(Color.black)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete { indexSet in
                            notebook.items.remove(atOffsets: indexSet)
                        }
                        .onMove { indices, newOffset in
                            notebook.items.move(fromOffsets: indices, toOffset: newOffset)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddScreen) {
                AddAssignmentView(notebook: notebook)
            }
        }
    }
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Assignment")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)

                    Text("Notebook")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                }

                Spacer()

                Button {
                    showingAddScreen = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }

            Text("Tap + to add  Swipe to delete  Edit to reorder")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(25)
        .padding(.horizontal)
        .padding(.top, 10)
    }
    private func assignmentCard(_ assignment: AssignmentItem) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(assignment.course)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(courseColor(assignment.course))
                    .cornerRadius(10)
                Spacer()
                Text(assignment.dueDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))
            }
            Text(assignment.description)
                .font(.headline)
                .foregroundColor(.white)
            Text("Due Date")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.5))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.08))
                .shadow(radius: 8)
        )
        .padding(.vertical, 6)
    }
    private func courseColor(_ course: String) -> Color {
        switch course {
        case "Math": return .blue
        case "English": return .red
        case "Science": return .green
        case "History": return .orange
        case "Computer Science": return .purple
        default: return .gray
        }
    }
}
#Preview {
    ContentView()
}
