//
//  RestaurantsTableViewController.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/3/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

struct RestaurantsViewConstants {
    static let cellIdentifier = "RestaurantTableViewCellId"
    static let showReviewsSegueIdentifier = "ShowReviews"
    static let addRestaurantSegueIdentifier = "AddRestaurant"
}

class RestaurantsTableViewController: UITableViewController {
    // MARK: Properties
    @IBOutlet weak var restaurantTableView: UITableView!
    
    let viewModel = RestaurantsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        viewModel.loadRestaurants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        restaurantTableView.reloadData()
    }
}

// MARK: - Table view Data Source

extension RestaurantsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = RestaurantsViewConstants.cellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        let restaurant = viewModel.restaurant(at: indexPath)
        cell.restaurant = restaurant
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //print("at: \(indexPath.row)") // Debug
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.removeRestaurant(at: indexPath)
            viewModel.saveRestaurants()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
        let editAction = self.contextualEditAction(forRowAtIndexPath: indexPath)
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeConfig
    }
    
    func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self] (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
                                            // Delete the row from the data source
                                            self?.viewModel.removeRestaurant(at: indexPath)
                                            self?.viewModel.saveRestaurants()
                                            self?.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return action
    }
    
    func contextualEditAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
                                            //To do - Implement Edit Restaurant feature
        }
        return action
    }
}

// MARK: - Navigation

extension RestaurantsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == RestaurantsViewConstants.showReviewsSegueIdentifier {
            let reviewsViewController = segue.destination as! ReviewsViewController
            
            if let selectedRestaurantCell = sender as? RestaurantTableViewCell {
                let indexPath = tableView.indexPath(for: selectedRestaurantCell)!
                let selectedRestaurant = viewModel.restaurant(at: indexPath)
                reviewsViewController.restaurant = selectedRestaurant
                reviewsViewController.indexpath = indexPath
                reviewsViewController.reviewCompletionHandler = {[weak self] restaurant in
                    self?.viewModel.updateRestaurant(restaurant, at: indexPath)
                    self?.viewModel.saveRestaurants()
                }
            }
        }
        else if segue.identifier == RestaurantsViewConstants.addRestaurantSegueIdentifier {
            //print("Adding new restaurant")
            let addRestaurantViewController = segue.destination as! AddRestaurantViewController
            addRestaurantViewController.viewModel = self.viewModel
            addRestaurantViewController.saveRestaurantsHandler = {[weak self] restaurant in
                let newIndexPath = IndexPath(row: self?.viewModel.restaurants.count ?? 0, section: 0)
                self?.viewModel.appendRestaurant(restaurant)
                self?.restaurantTableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }
}
