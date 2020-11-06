//
//  RestaurantsViewModel.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class RestaurantsViewModel {
    var restaurants = [Restaurant]()
    let dbManager = DatabaseManager.shared
    
    public func loadRestaurants() {
        // Load any saved Restaurants, otherwise load sample data.
        let savedRestaurants = loadRestaurantsFromDatabase()
        if savedRestaurants.count > 0 {
            restaurants += savedRestaurants
            //printRestaurants() // Debug
        }
        else {
            // Load the sample data.
            loadSampleRestaurants()
        }
    }
    
    // MARK: Persistence handlers

    func saveRestaurants() {
        dbManager.save(restaurants)
    }

    func loadRestaurantsFromDatabase() -> [Restaurant] {
        let nRestaurants = dbManager.loadElements() as [Restaurant]
        return nRestaurants
    }

    func loadSampleRestaurants() {
        let review1 = [Review(reviewDate: "Monday, 26th, 2010", userReview: "review 1", starRating: 1)]
        let restaurant1 = Restaurant(name: "Jo's kansas city", cuisineType: .CuisineTypeAmerican, reviews: review1)
        
        let review2 = [Review(reviewDate: "Tuesday, 26th, 2010", userReview: "review 22", starRating: 1), Review(reviewDate: "Friday, 26th, 2010", userReview: "review 221", starRating: 2)]
        let restaurant2 = Restaurant(name: "Bonefish Grill", cuisineType: .CuisineTypeItalian, reviews: review2)
        
        let review3 = [Review(reviewDate: "Wednesday, 26th, 2010", userReview: "review 32", starRating: 1), Review(reviewDate: "Thursday, 26th, 2010", userReview: "review 222", starRating: 2), Review(reviewDate: "Friday, 26th, 2010", userReview: "review 3", starRating: 3)]
        let restaurant3 = Restaurant(name: "Madras Kafe", cuisineType: .CuisineTypeAsian, reviews: review3)
        restaurants += [restaurant1, restaurant2, restaurant3]
        //printRestaurants() // Debug
    }
    
    func printRestaurants() {
      var i = 0
      for restaurant in restaurants {
        print("Restaurant.name: [\(i)] '\(restaurant.name)'") // Debug
        print("Restaurant.cuisine: [\(i)] '\(restaurant.cuisineType)'") // Debug
        print("Restaurant.review: [\(i)] '\(restaurant.reviews)'") // Debug
        i += 1
      }
    }
    
    func loadCuisineTypes() -> [CuisineType]{
        return [.CuisineTypeAmerican, .CuisineTypeItalian, .CuisineTypeAsian, .CuisineTypeChinese]
    }
    
    // MARK: Convenience methods
    
    /**
    Returns number of rows in section.

    - Parameters:
       - section: The table view section to filter rows
     
    - Returns: Number of rows.
    */
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return restaurants.count
    }
    
    /**
    Returns restaurant at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: The corresponding restaurant at indexpath.
    */
    
    func restaurant(at indexPath: IndexPath) -> Restaurant? {
        guard indexPath.row < restaurants.count  else { return nil }
        return restaurants[indexPath.row]
    }
    
    /**
    Removes restaurant at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: The corresponding restaurant at indexpath that is removed.
    */
    
    @discardableResult
    func removeRestaurant(at indexPath: IndexPath) -> Restaurant? {
        guard indexPath.row < restaurants.count  else { return nil }
        return restaurants.remove(at: indexPath.row)
    }
    
    /**
    Removes restaurant at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: None.
    */
    
    func insertRestaurant(_ restaurant: Restaurant, at indexPath: IndexPath) {
        restaurants.insert(restaurant, at:indexPath.row)
    }
    
    /**
    Updates restaurant at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: None.
    */
    
    func updateRestaurant(_ restaurant: Restaurant, at indexPath: IndexPath) {
        restaurants[indexPath.row] = restaurant
    }
    
    /**
    Appends restaurant at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: None.
    */
    
    func appendRestaurant(_ restaurant: Restaurant) {
        restaurants.append(restaurant)
    }
}
