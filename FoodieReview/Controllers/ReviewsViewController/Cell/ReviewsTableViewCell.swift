//
//  ReviewsTableViewCell.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblReviewDate: UILabel!
    @IBOutlet weak var lblStarRating: UILabel!
    @IBOutlet weak var lblUserReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var review: Review? {
        didSet {
            if let review = review {
                lblReviewDate.text = review.reviewDate
                lblUserReview.text = review.userReview
                lblStarRating.text = String(review.starRating)
            }
        }
    }

}
