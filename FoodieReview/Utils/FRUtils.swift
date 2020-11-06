//
//  FRUtils.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class FRUtils {
    class func cuisineTypeName(type: CuisineType) -> String {
        var cuisineTypeName = ""
        switch(type) {
            case CuisineType.CuisineTypeAmerican:
                cuisineTypeName = "American"
            
            case CuisineType.CuisineTypeItalian:
                cuisineTypeName = "Italian"
            
            case CuisineType.CuisineTypeChinese:
                cuisineTypeName = "Chinese"
            
            case CuisineType.CuisineTypeAsian:
                cuisineTypeName = "Asian"
        }
        return cuisineTypeName
    }
    
    class func cuisineType(name: String) -> CuisineType {
        var cuisineType = CuisineType.CuisineTypeAmerican
        switch(name) {
            case "Italian":
                cuisineType = CuisineType.CuisineTypeItalian
            
            case "Chinese":
                cuisineType = CuisineType.CuisineTypeChinese
            
            case "Asian":
                cuisineType = CuisineType.CuisineTypeAsian
            default:
              cuisineType = CuisineType.CuisineTypeAmerican
        }
        return cuisineType
    }
    
    class func ratingAverage(_ reviews: [Review]) -> String {
        guard reviews.count > 0 else {
            return "0"
        }
        let sum = reviews.reduce(0) { (result, review) in
            return review.starRating + result
        }
        let avg = Double(sum) / Double(reviews.count)
        return String(avg)
    }
}
