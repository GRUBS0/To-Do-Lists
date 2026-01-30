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
                            .foregroundColor(.blue)

                        Text(assignment.description)
                            .font(.subheadline)
                            .foregroundColor(.primary)

                        Text("Due: \(assignment.dueDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(.red)

                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
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
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Assignment Notebook")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .foregroundColor(.blue)
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
