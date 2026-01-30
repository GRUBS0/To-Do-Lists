import SwiftUI

struct ContentView: View {

    @State private var notebook = AssignmentList()
    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(notebook.items) { assignment in
                    VStack(alignment: .leading, spacing: 6) {

                        Text(assignment.course)
                            .font(.headline)
                            .foregroundColor(.cyan)

                        Text(assignment.description)
                            .font(.subheadline)
                            .foregroundColor(.white)

                        Text("Due: \(assignment.dueDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                    .padding(.vertical, 8)
                    // Adds 8 points of space **above and below** the view (top and bottom).
                    // This pushes the view away from other elements vertically.
                    .padding(.horizontal, 10)
                    // Adds 10 points of space on the left and right of the view.
                    // This pushes the view away from other elements horizontally.
                    .background(Color(.darkGray))
                    .cornerRadius(10)
                }
                .onDelete { indexSet in
                    notebook.items.remove(atOffsets: indexSet)
                }
                .onMove { indices, newOffset in
                    notebook.items.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.black)
            .navigationTitle("Assignment Notebook")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddAssignmentView(notebook: notebook)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course: String
    var description: String
    var dueDate: Date
}

#Preview {
    ContentView()
}
