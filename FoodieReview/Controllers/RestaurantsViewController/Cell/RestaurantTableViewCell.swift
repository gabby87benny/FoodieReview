//
//  RestaurantTableViewCell.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet weak var _lblAvgReview: UILabel!
    @IBOutlet weak var _lblRestaurantName: UILabel!
    @IBOutlet weak var _lblCuisineType: UILabel!
    @IBOutlet weak var _lblNumberOfReviews: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
            if let restaurant = restaurant {
                _lblRestaurantName.text = restaurant.name
                _lblCuisineType.text = FRUtils.cuisineTypeName(type: restaurant.cuisineType)
                _lblNumberOfReviews.text = String(restaurant.reviews.count)
                _lblAvgReview.text = FRUtils.ratingAverage(restaurant.reviews)
            }
        }
    }
}
