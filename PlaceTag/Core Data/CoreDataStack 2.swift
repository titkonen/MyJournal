import CoreData

final class CoreDataStack {
  static let shared = CoreDataStack()
  var context: NSManagedObjectContext {
    persistentContainer.viewContext
  }

  private lazy var persistentContainer: NSPersistentCloudKitContainer = {
    let container = NSPersistentCloudKitContainer(name: "PlaceTag")
    migrateIfRequired(container.persistentStoreCoordinator)
    container.persistentStoreDescriptions.first?.url = CoreDataStack.storeURL
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }()

  
  func migrateIfRequired(_ psc: NSPersistentStoreCoordinator) {
    //1
    if FileManager.default.fileExists(atPath: CoreDataStack.storeURL.path) {
      return
    }

    do {
      //2
      let store = try psc.addPersistentStore(
        ofType: NSSQLiteStoreType,
        configurationName: nil,
        at: CoreDataStack.storeURL,
        options: CoreDataStack.storeOptions)
      //3
      let newStore = try psc.migratePersistentStore(
        store,
        to: CoreDataStack.storeURL,
        options: [NSPersistentStoreRemoveUbiquitousMetadataOption: true],
        withType: NSSQLiteStoreType)
      //4
      try psc.remove(newStore)
    } catch {
      print("Error migrating store: \(error)")
    }
  }


  private static let storeOptions: [AnyHashable: Any] = [
    NSMigratePersistentStoresAutomaticallyOption: true,
    NSInferMappingModelAutomaticallyOption: true,
    NSPersistentStoreUbiquitousContentNameKey: "CloudStore"
  ]

  private static var storeURL: URL {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard let docURL = urls.last else {
      fatalError("Error fetching document directory")
    }
    let storeURL = docURL.appendingPathComponent("PlaceTag.sqlite")
    return storeURL
  }

  func saveContext() {
    context.saveContext()
  }
}
