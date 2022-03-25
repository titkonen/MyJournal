import SwiftUI

@main
struct MyJournalApp: App {
  
  @State private var coreDataStack = CoreDataStack.shared
  @AppStorage("appearance") var appearance: Appearance = .dark
  
    var body: some Scene {
        WindowGroup {
          TabBarView()
            .environment(\.managedObjectContext, CoreDataStack.shared.context)
//            PostListView()
//            .environment(\.managedObjectContext, coreDataStack.context)
            
        }
    }
}
