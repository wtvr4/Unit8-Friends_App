import SwiftUI

struct FriendDetailView: View {
    @Binding var friend: Friend
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
            TextField("Age", value: $friend.age, formatter: NumberFormatter())
                .foregroundColor(.gray)
            Toggle("Bestfriend?", isOn: $friend.isBestFriend)
        }
        .navigationTitle("Friend Detail")
    }
}

struct FriendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailView(friend: .constant(Friend(name: "test", age: 99)))
    }
}
