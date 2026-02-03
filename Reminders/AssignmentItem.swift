import Foundation

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course: String
    var description: String
    var dueDate: Date
}
