//
//  PostDetailView.swift
//  MyJournal
//
//  Created by Toni Itkonen on 25.3.2022.
//

import SwiftUI

struct PostDetailView: View {
  let title: String?
  let subtitle: String?
  let image: UIImage?
//  let kuva: UIImage?

  var body: some View {
    ScrollView {
      VStack {
        image.map {
          Image(uiImage: $0)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 10)
        }
//        kuva.map{
//          Image(uiImage: $0)
//            .renderingMode(.original)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .cornerRadius(8)
//            .shadow(radius: 10)
//        }
        title.map {
          Text($0)
            .font(.largeTitle)
        }
        subtitle.map {
          Text($0)
            .font(.title)
            .foregroundColor(.secondary)
        }
      }
      .multilineTextAlignment(.center)
      .padding()
    }
    .navigationBarTitle(Text(""), displayMode: .inline)
  }
}

struct PostDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PostDetailView(
      title: "San Francisco",
      subtitle: "Golden Gate was awesome",
      image: UIImage(systemName: "photo")
    )
  }
}
