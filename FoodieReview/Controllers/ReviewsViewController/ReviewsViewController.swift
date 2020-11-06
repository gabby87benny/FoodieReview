//
//  ReviewsViewController.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

struct ReviewsViewConstants {
    static let cellIdentifier = "ReviewTableViewCellId"
    static let sectionHeaderNib = "ReviewsTableHeaderView"
    static let sectionHeaderIdentifier = "ReviewsTableHeaderViewId"
    static let addReviewSegueIdentifier = "AddReview"
}

class ReviewsViewController: UIViewController {
    let viewModel = ReviewsViewModel()

    // MARK: - Properties
    
    weak var restaurant: Restaurant? {
        didSet {
            viewModel.restaurant = restaurant
        }
    }
    
    var indexpath: IndexPath? {
        didSet {
            viewModel.indexpath = indexpath
        }
    }
    
    @IBOutlet weak var reviewsTableView : UITableView!
    var reviewCompletionHandler: ((Restaurant) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: ReviewsViewConstants.sectionHeaderNib, bundle: nil)
        reviewsTableView.register(nib, forHeaderFooterViewReuseIdentifier: ReviewsViewConstants.sectionHeaderIdentifier)
        reviewsTableView.tableFooterView = UIView()
        
        if let restaurant = restaurant {
            navigationItem.title = "Reviews \(restaurant.reviews.count)"
        }
    }
}

// MARK: - Table view Data source

extension ReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsViewConstants.cellIdentifier, for: indexPath) as! ReviewsTableViewCell
        cell.review = viewModel.review(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

// MARK: - Table view Delegate

extension ReviewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReviewsViewConstants.sectionHeaderIdentifier) as! ReviewsTableHeaderView
        headerView.restaurant = restaurant
        return headerView
    }
}

// MARK: - Navigation

extension ReviewsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ReviewsViewConstants.addReviewSegueIdentifier {
            //print("Adding new review")
            let addReviewViewController = segue.destination as! AddReviewViewController
            addReviewViewController.saveReviewsHandler = {[weak self] review in
                let reviews = self?.viewModel.restaurant?.reviews
                let newIndexPath = IndexPath(row: reviews?.count ?? 0, section: 0)
                self?.viewModel.appendReview(review)
                self?.reviewsTableView.insertRows(at: [newIndexPath], with: .bottom)
                
                if let completion = self?.reviewCompletionHandler, let restaurant = self?.viewModel.restaurant {
                    completion(restaurant)
                    self?.reviewsTableView.reloadData()
                }
            }
        }
    }
}
