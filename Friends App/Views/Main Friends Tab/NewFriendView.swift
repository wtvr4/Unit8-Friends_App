import SwiftUI

struct NewFriendView: View {
    @State private var friendName = ""
    @State private var friendAge = ""
    @State private var isBestFriend = false
    @Binding var sourceArray: [Friend]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("Info") {
                TextField("Name", text: $friendName)
                TextField("Age", text: $friendAge)
                Toggle("Bestfriend?", isOn: $isBestFriend)
                    
            }
            Section("Actions") {
                Button("Save") {
                    if let age = Int(friendAge) {
                        let friend = Friend(name: friendName, age: age)
                        sourceArray.append(friend)
                        dismiss()
                    }
                }
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}

struct NewFriendView_Previews: PreviewProvider {
    static var previews: some View {
        NewFriendView(sourceArray: .constant([]))
    }
}
