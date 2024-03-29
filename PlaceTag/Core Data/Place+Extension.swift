import UIKit.UIImage
import CoreData.NSManagedObjectContext

extension Place {
	static func create(
    title: String?,
    note: String?,
    image: UIImage?,
    context: NSManagedObjectContext,
    kuva: UIImage?
  ) {
		let newPlace = Place(context: context)
		newPlace.id = UUID()
		newPlace.title = title?.isEmpty == false ? title : "Untitled"
		newPlace.note = note?.isEmpty == false ? note : nil
		newPlace.image = image?.pngData()
    newPlace.kuva = kuva?.pngData()
		newPlace.date = Date()
		context.saveContext()
	}
}
