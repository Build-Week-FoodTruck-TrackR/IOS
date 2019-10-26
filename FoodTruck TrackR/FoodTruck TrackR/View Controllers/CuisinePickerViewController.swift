//
//  CuisinePickerViewController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/24/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class CuisinePickerViewController: UIViewController {


	@IBOutlet private weak var cuisinePicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddTruckViewController: UIPickerViewDelegate, UIPickerViewDataSource {

func numberOfComponents(in pickerView: UIPickerView) -> Int {
	return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
	return cuisinePickerData.count
}

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
	return cuisinePickerData[row].rawValue
}

public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
	let cuisineData = cuisinePickerData[row]
	let cuisine = NSAttributedString(string: cuisineData.rawValue,
                                     attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica",
                                                                                      size: 17.0)!,
                                                  NSAttributedString.Key.foregroundColor: UIColor.white])
	return cuisine
}
}
