import Foundation
import SwiftUI

class FriendManager: ObservableObject {
    @Published var friends: [Friend] = [] {
        didSet {
            save()
        }
    }
    
    @Published var serchTerms = ""
    
    var todosFiltered: Binding<[Friend]> {
        Binding (
            get: {
                if self.serchTerms == "" {return self.friends}
                return self.friends.filter {
                    $0.name.lowercased().contains(self.serchTerms.lowercased())
                }
            },
            set:{
                self.friends = $0
            }
        )
        
    }
    var numFriendsLeft : Int { friends.filter { !$0.isBestFriend }.count }
    var numFriendsDone : Int { friends.filter { $0.isBestFriend }.count }

    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "friends.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedFriends = try? propertyListEncoder.encode(friends)
        try? encodedFriends?.write(to: archiveURL, options: .noFileProtection)
    }
   
    func loadSampleData() {
        let friend1 = Friend(name: "Saif", age: 16, isBestFriend: true)
        let friend2 = Friend(name: "Rashid", age: 15)
        let friend3 = Friend(name: "Ahmed", age: 17)
        friends = [friend1, friend2, friend3]
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        print(archiveURL)
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedFriendData = try? Data(contentsOf: archiveURL),
            let friendsDecoded = try? propertyListDecoder.decode([Friend].self, from: retrievedFriendData) {
            friends = friendsDecoded
        }
    }
}

