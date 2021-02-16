//
//  URLData.swift
//  LinkMark
//
//  Created by Woogie on 2021/01/18.
//
import Foundation
import CoreData

class URLAddress {

    static let shared = URLAddress()
    private init() {
        //Singleton
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var urlList = [Favorite]()

    func fetchURL(_ searchText: String? = nil) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        if searchText != nil {
            request.predicate = NSPredicate(format: "name contains[cd] %@ or address contains[cd] %@", searchText!, searchText!)
            do {
                urlList = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        } else {
            do {
                urlList = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        //정렬
        let sortByData = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortByData]
    }
    
    func startFetchURL() {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        //정렬
        let sortByData = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortByData]
        
        do {
            urlList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    // url추가
    func addUrl(_ address: String?, _ name: String?) {
        let newFavorite = Favorite(context: mainContext)
        newFavorite.address = address
        newFavorite.name = name
        
        urlList.insert(newFavorite, at: 0)
        saveContext()
        startFetchURL()
    }
    
    // url삭제
    func deleteUrl(_ url: Favorite?) {
        if let url = url {
            mainContext.delete(url)
            saveContext()
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "LinkMark")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
