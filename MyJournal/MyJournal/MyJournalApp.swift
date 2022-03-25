import SwiftUI

@main
struct MyJournalApp: App {
  
  @State private var coreDataStack = CoreDataStack.shared
  
    var body: some Scene {
        WindowGroup {
            PostListView()
//            .environment(\.managedObjectContext, coreDataStack.context)
            .environment(\.managedObjectContext, CoreDataStack.shared.context)
        }
    }
}
