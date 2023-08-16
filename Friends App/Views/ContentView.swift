import SwiftUI

struct ContentView: View {
    
@StateObject var friendManger = FriendManager()
    var body: some View {
        TabView{
            MainFriendListView(friendManager: friendManger)
                .tabItem{
                    Label("Friends", systemImage: "person.3")
                }
            BestfriendsView(friendManager: friendManger)
                .tabItem{
                    Label("Bestfriends", systemImage: "face.smiling.inverse")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
