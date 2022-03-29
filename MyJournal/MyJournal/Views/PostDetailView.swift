import SwiftUI

struct PostDetailView: View {
  let date: Date
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
        
        Text("\(date.formatted(date: .numeric, time: .omitted))")
            .font(.caption)

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
      date: Date(),
      title: "This is headline",
      subtitle: "This is subtitle",
      image: UIImage(systemName: "photo")
    )
  }
}
