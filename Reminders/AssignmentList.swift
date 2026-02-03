import Foundation
import Combine

class AssignmentList: ObservableObject {

    @Published var items: [AssignmentItem] = [] {
        didSet { save() }
    }

    private let saveKey = "assignments"

    init() {
        load()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([AssignmentItem].self, from: data) {
            items = decoded
        } else {
            items = []
        }
    }
}
