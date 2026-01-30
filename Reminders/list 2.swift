import SwiftUI
import Observation

struct AddAssignmentView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var notebook: AssignmentList
    let courses = ["Math", "English", "Science", "History", "Computer Science"]
    @State private var course = "Math"
    @State private var description = ""
    @State private var dueDate = Date()

    var body: some View {
        NavigationStack {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(courses, id: \.self) { c in
                        Text(c)
                    }
                }
                TextField("Assignment Description", text: $description)

                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationTitle("Add New Assignment")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if description.trimmingCharacters(in: .whitespaces).isEmpty { return }
                        let newAssignment = AssignmentItem(course: course,
                description: description,
                                                          dueDate: dueDate)

                        notebook.items.append(newAssignment)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddAssignmentView(notebook: AssignmentList())
}
