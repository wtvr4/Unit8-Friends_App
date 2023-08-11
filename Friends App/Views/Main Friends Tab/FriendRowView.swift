import SwiftUI

struct FriendRowView: View {
    @Binding var friend: Friend
    
    var body: some View {
        NavigationLink {
            FriendDetailView(friend: $friend)
        } label: {
            HStack {
                Image(systemName: friend.isBestFriend ? "face.smiling.inverse" : "circle")
                    .onTapGesture {
                        friend.isBestFriend.toggle()
                    }
                VStack(alignment: .leading) {
                    Text(friend.name)
                }
            }
        }
    }
}

struct FriendRowView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRowView(friend: .constant(Friend(name: "test", age: 99)))
    }
}
