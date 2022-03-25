//
//  PostListView.swift
//  MyJournal
//
//  Created by Toni Itkonen on 25.3.2022.
//

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
        .overlay(places.isEmpty ? Text("Add a place using the button below") : nil, alignment: .center)

        NavigationLink(destination: AddPostView()) {
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
      title: place.title,
      subtitle: place.note,
      image: place.image?.uiImage
//      kuva: place.image?.uiImage
    )
  }

  private func makeItemView(from place: JournalEntity) -> PostItemView {
    return PostItemView(
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

