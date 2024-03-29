import SwiftUI
import CoreData

struct PostListView: View {
  @FetchRequest(entity: JournalEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntity.date, ascending: false)])
  private var places: FetchedResults<JournalEntity>
  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      ZStack(alignment: .bottomTrailing) {
        List {
          ForEach(places, id: \.id) { place in
            NavigationLink(destination: makeDetailView(from: place)) {
              makeItemView(from: place)
            }
          }.onDelete(perform: deletePlaces)
        }
        .listStyle(GroupedListStyle())
        .overlay(places.isEmpty ? Text("Add a post using the button below") : nil, alignment: .center)

        NavigationLink(destination: AddPostView(date: Date())) {
          HStack {
            Image(systemName: "plus.circle.fill")
            Text("Add Post")
          }
        }
        .buttonStyle(ActionButtonBackgroundStyle())
      }
      .navigationBarTitle("My Journal")
    }
  }

  private func makeDetailView(from place: JournalEntity) -> PostDetailView {
    return PostDetailView(
      date: place.date ?? Date(),
      title: place.title,
      subtitle: place.note,
      image: place.image?.uiImage
//      kuva: place.image?.uiImage
    )
  }

  private func makeItemView(from place: JournalEntity) -> PostItemView {
    return PostItemView(
      date: place.date ?? Date(),
      title: place.title,
      subtitle: place.note,
      image: place.image?.uiImage
    )
  }

  private func deletePlaces(at indices: IndexSet) {
    DispatchQueue.main.async {
      var result: [JournalEntity] = []
      for index in indices {
        result.append(places[index])
      }
      viewContext.delete(result)
    }
  }
}

