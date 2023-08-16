import SwiftUI

struct MainFriendListView: View {
    @State private var showAddSheet = false
    @State private var showConfirmAlert = false
    @ObservedObject var friendManager: FriendManager

    var body: some View {
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
                    Button{
                        showConfirmAlert = true
                    } label: {
                        Image(systemName: "list.bullet.clipboard.fill")
                    }
                    Button{
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
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

struct MainFriendListView_Previews: PreviewProvider {
    static var previews: some View {
        MainFriendListView(friendManager: FriendManager())
    }
}
