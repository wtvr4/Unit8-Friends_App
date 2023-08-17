import SwiftUI

struct MainFriendListView: View {
    @State private var showAddSheet = false
    @State private var showConfirmAlert = false
    @ObservedObject var friendManager: FriendManager
    
    var body: some View {
        ZStack {
            VStack {
                NavigationStack {
                    List($friendManager.friends, editActions: [.all]) { $friend in
                        FriendRowView(friend: $friend)
                    }
                    .searchable(text: $friendManager.serchTerms)
                    .navigationTitle("Friends")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button {
                                showConfirmAlert = true
                            } label: {
                                Image(systemName: "list.bullet.clipboard.fill")
                            }
                            
                            #if DEBUG
                            Button {
                                showAddSheet = true
                            } label: {
                                Image(systemName: "plus")
                            }
                            #endif
                            
                            Menu {
                                Text("Sort By...")
                                Button("Name", action: sortByName)
                                Button("Preference", action: sortByBest)
                                
                            } label: {
                                Image(systemName: "ellipsis.circle")
                            }
                        }
                    }
                    .sheet(isPresented: $showAddSheet){
                        NewFriendView(sourceArray: $friendManager.friends)
                    }
                    .alert("Load sample data? Warning: This cannot be undone!", isPresented: $showConfirmAlert) {
                        Button("Replace", role: .destructive) {
                            friendManager.loadSampleData()
                        }
                    }
                }
            }
        }
    }
    
    func sortByName() {
        friendManager.friends.sort { $0.name.lowercased() <  $1.name.lowercased() }
    }
    
    func sortByBest() {
        friendManager.friends.sort { ($0.isBestFriend ? 0 : 1 ) < ($1.isBestFriend ? 0 : 1 ) }
    }
}

struct MainFriendListView_Previews: PreviewProvider {
    static var previews: some View {
        MainFriendListView(friendManager: FriendManager())
    }
}
