import UIKit.UIImage
import CoreData.NSManagedObjectContext

extension JournalEntity {
  static func create(
    title: String?,
    note: String?,
    image: UIImage?,
    context: NSManagedObjectContext
  ) {
    let newJournalPost = JournalEntity(context: context)
    newJournalPost.id = UUID()
    newJournalPost.title = title?.isEmpty == false ? title : "Untitled"
    newJournalPost.note = note?.isEmpty == false ? note : nil
    newJournalPost.image = image?.pngData()
    newJournalPost.date = Date()
    context.saveContext()
  }
}
