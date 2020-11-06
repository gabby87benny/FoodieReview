//
//  Restaurant.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

enum CuisineType {
    case CuisineTypeAmerican
    case CuisineTypeItalian
    case CuisineTypeChinese
    case CuisineTypeAsian
}

class Restaurant: NSObject, NSCoding {
    // MARK: Properties
    var name: String
    var cuisineType: CuisineType
    var reviews = [Review]()
    
    // MARK: Types

    struct PropertyKey {
      static let nameKey = "name"
      static let cuisineTypeKey = "cuisineType"
      static let reviewsKey = "reviews"
    }

    // MARK: Initialization

    init(name: String, cuisineType: CuisineType, reviews: [Review] = [Review]()) {
        // Initialize stored properties.
        self.name = name
        self.cuisineType = cuisineType
        self.reviews = reviews
        super.init() // Call superclass initializer
    }
    
    class func createRestaurant(name: String, cuisineType: CuisineType, reviews: [Review] = [Review]()) -> Restaurant {
        return Restaurant(name: name, cuisineType: cuisineType, reviews: reviews)
    }
    
    // MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(FRUtils.cuisineTypeName(type: cuisineType), forKey: PropertyKey.cuisineTypeKey)
        aCoder.encode(reviews, forKey: PropertyKey.reviewsKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let cuisineTypeName = aDecoder.decodeObject(forKey: PropertyKey.cuisineTypeKey) as! String
        let type = FRUtils.cuisineType(name: cuisineTypeName)
        let reviews = aDecoder.decodeObject(forKey: PropertyKey.reviewsKey) as! [Review]
        // Must call designated initializer.
        self.init(name: name, cuisineType: type, reviews: reviews)
    }
}
