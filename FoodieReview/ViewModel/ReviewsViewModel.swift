//
//  ReviewsViewModel.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class ReviewsViewModel: NSObject {
    weak var restaurant: Restaurant?
    var indexpath: IndexPath?
    let dbManager = DatabaseManager.shared

    /**
    Returns number of rows in section.

    - Parameters:
       - section: The table view section to filter rows
     
    - Returns: Number of rows.
    */
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return restaurant?.reviews.count ?? 0
    }
    
    /**
    Returns review at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: The corresponding review at indexpath.
    */
    
    func review(at indexPath: IndexPath) -> Review? {
        guard let restaurant = restaurant, indexPath.row < restaurant.reviews.count  else { return nil }
        return restaurant.reviews[indexPath.row]
    }
    
    /**
    Appends review at indexpath.

    - Parameters:
       - indexPath: The indexpath to look for
     
    - Returns: None.
    */
    
    func appendReview(_ review: Review) {
        if let restaurant = restaurant {
            restaurant.reviews.append(review)
        }
    }
}
