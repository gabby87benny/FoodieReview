//
//  DatabaseManager.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class DatabaseManager: NSObject {
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = DocumentsDirectory.appendingPathComponent("restaurants")
    
    static let shared = DatabaseManager()
    
    // Initialization
    private override init() {
        
    }
    
    /**
    Saves objects to database.

    - Parameters:
       - objects: Array of elements to be saved
     
    - Returns: None.
    */
    
    func save<Element>(_ objects: [Element]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: objects, requiringSecureCoding: false)
            try data.write(to: DatabaseManager.archiveURL)
        } catch let exception {
            print("Failed to save restaurants with exception: \(exception.localizedDescription)")
        }
    }

    /**
    Loads elements from Database.

    - Parameters:
       - None
     
    - Returns: Array of elements.
    */
    
    func loadElements<Element>() -> [Element] {
        var storedElements: [Element] = []
        do {
            let data = try Data(contentsOf: DatabaseManager.archiveURL)
            if let arrElements = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Element] {
                storedElements = arrElements
            }
        } catch {
            print("Couldn't read elements from database.")
        }
        return storedElements
    }
}
