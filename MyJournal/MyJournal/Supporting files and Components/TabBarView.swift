import SwiftUI

struct TabBarView: View {
  @AppStorage("appearance") var appearance: Appearance = .automatic
  
    var body: some View {
      TabView {
        PostListView()
          .tabItem({
            VStack {
              Image(systemName: "list.bullet")
              Text("Posts")
            }
          })
          .tag(0)
          .preferredColorScheme(appearance.getColorScheme())
        
        SettingsView()
            .tabItem({
              VStack {
                Image(systemName: "gear")
                Text("Settings")
              }
            })
            .tag(1)
      }
      .accentColor(.blue)

    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
      TabBarView()
    }
}
