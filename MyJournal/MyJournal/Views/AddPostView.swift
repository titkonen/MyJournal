//
//  AddPostView.swift
//  MyJournal
//
//  Created by Toni Itkonen on 25.3.2022.
//

import SwiftUI

struct AddPostView: View {
  @State var date: Date
  @State private var title: String = ""
  @State private var note: String = ""
  @State private var image: UIImage?
  @State private var shouldShowImagePicker = false

  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.presentationMode) private var presentationMode

  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      Form {
        Section(header: Text("Day")) {
          DatePicker("Date", selection: $date, displayedComponents: .date)
        }
        
        Section(header: Text("Title")) {
          TextField("Insert title", text: $title)
            .autocapitalization(.words)
        }

        Section(header: Text("Notes")) {
          TextField("Insert notes", text: $note)
            .autocapitalization(.sentences)
        }

        Section {
          Button(
            action: {
              shouldShowImagePicker.toggle()
            },
            label: makeImageForChoosePhotosButton
          )
        }
      }

      Button(
        action: {
          JournalEntity.create(date: date, title: title, note: note, image: image, context: viewContext)
          presentationMode.wrappedValue.dismiss()
        },
        label: {
          HStack {
            Image(systemName: "square.and.arrow.down.fill")
            Text("Save Post")
          }
        }
      )
      .buttonStyle(ActionButtonBackgroundStyle())
    }
    .navigationBarTitle("Add Post")
    .sheet(isPresented: $shouldShowImagePicker) {
      ImagePicker(image: $image)
    }
  }

  @ViewBuilder
  private func makeImageForChoosePhotosButton() -> some View {
    image.map {
      Image(uiImage: $0)
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fill)
    }

    if image == nil {
      HStack {
        Spacer()
        Image(systemName: "photo.on.rectangle")
        Text("Choose Photo")
        Spacer()
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
  }
}

struct AddPlaceView_Previews: PreviewProvider {
  static var previews: some View {
    AddPostView(date: Date())
  }
}

