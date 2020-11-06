//
//  AddReviewViewController.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtViewAddReview: UITextView!
    @IBOutlet weak var viewStarRating: RatingControl!
    @IBOutlet weak var datePickerReview: UIDatePicker!
    @IBOutlet weak var stackView: UIStackView!
    
    var saveReviewsHandler: ((Review) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtViewAddReview.layer.cornerRadius = 2.0
        txtViewAddReview.layer.borderWidth = 2.0
        btnSave.isEnabled = false
    }
    
    // MARK: - Button actions
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if let userReviewText = txtViewAddReview.text, userReviewText.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            let strDate = dateFormatter.string(from: datePickerReview.date)
            
            let review = Review(reviewDate: strDate, userReview: userReviewText, starRating: viewStarRating.rating)
            if let handler = saveReviewsHandler {
                handler(review)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Text field Delegate

extension AddReviewViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let text = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        btnSave.isEnabled = (text.count > 0)
        return true
    }
}
