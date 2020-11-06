//
//  ReviewsTableHeaderView.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/5/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class ReviewsTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblRestaurantCuisineType: UILabel!
    @IBOutlet weak var lblRestaurantAvgReviews: UILabel!

    var restaurant: Restaurant? {
        didSet {
            if let restaurant = restaurant {
                lblRestaurantName.text = restaurant.name
                lblRestaurantCuisineType.text = FRUtils.cuisineTypeName(type: restaurant.cuisineType)
                lblRestaurantAvgReviews.text = FRUtils.ratingAverage(restaurant.reviews)
            }
        }
    }
}
