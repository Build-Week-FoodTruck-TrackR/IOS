//
//  AddTruckViewController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/24/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit
import CoreData

class AddTruckViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	// MARK: - Outlets
	@IBOutlet private weak var truckNameTextField: UITextField!
	@IBOutlet private weak var cuisineTypeTextField: UITextField!
	@IBOutlet private weak var truckImageView: UIImageView!

	// MARK: - Properties
	var truckController = TruckController.shared
	var cuisine: CuisineType?
    var imageURLString: String?
	var cuisinePickerData: [CuisineType] = []
	var cuisinePicker: UIPickerView! = UIPickerView()
	var imagePickerController = UIImagePickerController()

	var truckRep: TruckRepresentation {
		let moc = CoreDataStack.shared.mainContext
		let request: NSFetchRequest<Truck> = Truck.fetchRequest()

		do {
			let trucks = try moc.fetch(request)
			if let truck = trucks.first,
				let truckRep = truck.truckRepresentation {
				return truckRep			}
		} catch {
			fatalError("Error fetching truck: \(error)")
		}
		return TruckRepresentation()
	}

	// MARK: - View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()
		//setupPicker()
	}

	// Setup Views
	private func setupViews() {

		let navBarAppearance = UINavigationBarAppearance()

		view.backgroundColor = UIColor.titleBarColor

        tabBarController?.tabBar.barStyle = .default
		tabBarController?.tabBar.barTintColor = UIColor.titleBarColor
		tabBarController?.tabBar.tintColor = UIColor.textWhite

		navBarAppearance.configureWithDefaultBackground()
		navBarAppearance.backgroundColor = UIColor.titleBarColor

		navigationItem.title = "Add A Truck"
        navigationController?.navigationBar.barStyle = .default
		navigationController?.navigationBar.barTintColor = UIColor.titleBarColor
		navigationController?.navigationBar.backgroundColor = UIColor.titleBarColor


		navigationController?.navigationBar.tintColor = UIColor.textWhite
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
    }

	@IBAction func addTruckButton(_ sender: UIBarButtonItem) {
        guard let truckName = truckNameTextField.text,
            !truckName.isEmpty,
            let cuisine = cuisineTypeTextField.text,
            !cuisine.isEmpty else { return }
         guard let image = imageURLString else { return }
        print(image)
        truckController.createTruck(with: truckName, location: Location(longitude: 0.0, latitude: 0.0), imageOfTruck: image)
        dismiss(animated: true, completion: nil)
	}
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
               let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
               imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
           }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let truckImageUrl = info[.imageURL] as? URL else { return }
        imageURLString = truckImageUrl.absoluteString
    
        do {
        let truckImageData = try Data(contentsOf: truckImageUrl)
            truckImageView.image = UIImage(data: truckImageData)
            dismiss(animated: true, completion: nil)
        } catch {
            NSLog("failed to get image")
        }
    }

//    func convertUrloString(url: URL) {
//        do {
//            imageURLString  = url.absoluteString
//        } catch {
//            NSLog("failed to convert url to string")
//        }
//
//}
}

extension AddTruckViewController: UITextFieldDelegate {

//func numberOfComponents(in pickerView: UIPickerView) -> Int {
//	return 1
//}
//
//func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//	return cuisinePickerData.count
//}
//
//func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//	return cuisinePickerData[row].rawValue
//}
//
//public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//	let cuisineData = cuisinePickerData[row]
//	let cuisine = NSAttributedString(string: cuisineData.rawValue,
//                                     attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica",
//                                                                                      size: 17.0)!,
//                                                  NSAttributedString.Key.foregroundColor: UIColor.white])
//	return cuisine
//}

	private func setupPicker() {

		//cuisinePicker.delegate = self as UIPickerViewDelegate
		//cuisinePicker.dataSource = self as UIPickerViewDataSource
		self.view.addSubview(cuisinePicker)
		cuisinePicker.center = self.view.center
		// Sets Cuisine Picker View
		cuisinePicker.backgroundColor = UIColor.textWhite

		// Sets Cuisine delegate and datasource
		cuisinePicker.dataSource = self
		cuisinePicker.delegate = self

		// Sets the textfields
		cuisineTypeTextField.inputView = cuisinePicker
		for cuisine in CuisineType.allCases {
			cuisinePickerData.append(cuisine)
		}
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField == cuisineTypeTextField {
			performSegue(withIdentifier: "CuisinePickerSegue", sender: self)
		}
	}
}
