import Foundation
import Observation

@Observable
class AssignmentList {

    var items: [AssignmentItem] = [] {
        didSet {
            save()
        }
    }

    private let saveKey = "assignmentItems"

    init() {
        load()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    private func load() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([AssignmentItem].self, from: savedData) {
            items = decoded
        } else {
            items = [
                AssignmentItem(course: "Math", description: "Homework 5", dueDate: Date()),
                AssignmentItem(course: "English", description: "Essay draft", dueDate: Date()),
                AssignmentItem(course: "Science", description: "Lab report", dueDate: Date())
            ]
        }
    }
}

