import SwiftUI

struct BestfriendsView: View {
    @ObservedObject var friendManager: FriendManager
    var body: some View {
        VStack{
            Text("You have")
                .font(.largeTitle)
            Text("\(friendManager.numFriendsDone)")
                .font(.system(size:140))
                .foregroundColor(.yellow)
                .padding()
            Text("Bestfriends")
                .font(.largeTitle)
            
        }
    }
}

struct BestfriendsView_Previews: PreviewProvider {
    static var previews: some View {
        BestfriendsView(friendManager: FriendManager())
    }
}
