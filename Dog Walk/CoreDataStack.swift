//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Hai Vo L. on 11/13/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {

  private let modelName: String

  init(modelName: String) {
    self.modelName = modelName
  }

  //MARK: - Properties
  private lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: self.modelName)
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  lazy var managedContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()

  // MARK: - Func
  func saveContext() {
    guard managedContext.hasChanges else { return }

    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }

}
