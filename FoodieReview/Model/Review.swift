//
//  Review.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class Review: NSObject, NSCoding {
    // MARK: Properties
    
    var reviewDate: String
    var userReview: String
    var starRating: Int
    
    // MARK: Types
    
    struct PropertyKey {
        static let dateKey = "reviewDate"
        static let reviewKey = "reviewComment"
        static let ratingKey = "reviewRating"
    }
    
    // MARK: Initialization
    
    init(reviewDate: String, userReview: String, starRating: Int) {
        // Initialize stored properties.
        self.reviewDate = reviewDate
        self.userReview = userReview
        self.starRating = starRating
        super.init() // Call superclass initializer
    }
    
    class func createReview(reviewDate: String, userReview: String, starRating: Int) -> Review {
        return Review(reviewDate: reviewDate, userReview: userReview, starRating: starRating)
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(reviewDate, forKey: PropertyKey.dateKey)
        aCoder.encode(userReview, forKey: PropertyKey.reviewKey)
        aCoder.encode(starRating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObject(forKey: PropertyKey.dateKey) as! String
        let review = aDecoder.decodeObject(forKey: PropertyKey.reviewKey) as! String
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
        // Must call designated initializer.
        self.init(reviewDate: date, userReview: review, starRating: rating)
    }
}
