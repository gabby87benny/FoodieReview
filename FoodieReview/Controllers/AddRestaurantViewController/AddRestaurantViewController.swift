//
//  AddRestaurantViewController.swift
//  FoodieReview
//
//  Created by Joseph Peter, Gabriel Benny Francis on 11/4/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class AddRestaurantViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var pickerCuisineType: UIPickerView!
    @IBOutlet weak var txtFieldRestaurantName: UITextField!
    
    var viewModel: RestaurantsViewModel!
    var saveRestaurantsHandler: ((Restaurant) -> Void)?
    var chosenCuisineType = CuisineType.CuisineTypeAmerican //default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.isEnabled = false
    }
    
    // MARK: - Button actions
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if let userText = txtFieldRestaurantName.text, userText.count > 0 {
            let restaurant = Restaurant.createRestaurant(name: userText, cuisineType: chosenCuisineType)
            if let handler = saveRestaurantsHandler {
                handler(restaurant)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Picker Data source

extension AddRestaurantViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.loadCuisineTypes().count
    }
}

// MARK: - Picker Delegate

extension AddRestaurantViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let cuisineTypeName = FRUtils.cuisineTypeName(type: viewModel.loadCuisineTypes()[row])
        return cuisineTypeName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCuisineType = viewModel.loadCuisineTypes()[row]
    }
}

// MARK: - Text field delegate

extension AddRestaurantViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        btnSave.isEnabled = (text.count > 0)
        return true
    }
}
