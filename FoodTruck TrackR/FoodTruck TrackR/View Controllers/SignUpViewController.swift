//
//  SignUpViewController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/23/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var signUpButtonLabel: UIButton!
	@IBOutlet weak var vendorSwitch: UISwitch!

	let vendorController = VendorController.shared
	let consumerController = ConsumerController.shared

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		// Do any additional setup after loading the view.
	}

	private func setupViews() {
		view.backgroundColor = UIColor.titleBarColor

		passwordTextField.isSecureTextEntry = true

		signUpButtonLabel.tintColor = UIColor.textWhite

		navigationController?.navigationBar.barStyle = .default
		navigationController?.navigationBar.tintColor = UIColor.textWhite
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleBarColor]
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleBarColor]
	}

	@IBAction func signUpTapped(_ sender: UIButton) {
		guard let username = usernameTextField.text,
			let password = passwordTextField.text,
			let email = emailTextField.text else { return }
		if (!vendorSwitch.isOn) {
			consumerController.register(user: ConsumerSignup(username: username, password: password, email: email)) { error in
				if error == nil {
					DispatchQueue.main.async {
						self.dismiss(animated: true, completion: nil)
					}
				}
			}
		} else if (vendorSwitch.isOn) {
			vendorController.register(user: VendorSignup(username: username, password: password, email: email)) { error in
				if error == nil {
					DispatchQueue.main.async {
						self.dismiss(animated: true, completion: nil)
					}
				}
			}
		}
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
