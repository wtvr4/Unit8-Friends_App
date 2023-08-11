import Foundation

struct Friend: Identifiable, Codable {
    let id = UUID()
    var name: String
    var age: Int
    var isBestFriend = false
}
