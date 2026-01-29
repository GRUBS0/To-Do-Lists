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

                        Text(assignment.description)
                            .font(.subheadline)

                        Text("Due: \(assignment.dueDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete { indexSet in
                    notebook.items.remove(atOffsets: indexSet)
                }
                .onMove { indices, newOffset in
                    notebook.items.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .navigationTitle("Assignment Notebook")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddAssignmentView(notebook: notebook)
            }
        }
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
