//
//  LoginViewController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/20/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var loginSegmentedControl: UISegmentedControl!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	static var isVendor: Bool = false

	let vendorController = VendorController.shared
	let consumerController = ConsumerController.shared

	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()
	}

	private func setupViews() {
		view.backgroundColor = .background

		passwordTextField.isSecureTextEntry = true

		loginSegmentedControl.backgroundColor = .text

		loginButton.backgroundColor = .text
		loginButton.setTitleColor(UIColor.background, for: .normal)
		loginButton.layer.cornerRadius = 8

		navigationController?.navigationBar.barStyle = .default
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
	}

	@IBAction func loginTapped(_ sender: UIButton) {
		guard let username = usernameTextField.text,
			let password = passwordTextField.text else { return }
        if LoginViewController.isVendor {
            vendorController.logIn(user: VendorLogin(username: username, password: password)) { error in
                if let error: NetworkError = error {
                    NSLog("Error returned when trying to log in: \(error)")
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Unable to Log In", message: "Please check your username and password and try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    return
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
		} else {
            consumerController.logIn(user: ConsumerLogin(username: username, password: password)) { error in
                if let error: NetworkError = error {
                    NSLog("Error returned when trying to log in: \(error)")
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Unable to Log In", message: "Please check your username and password and try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    return
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
		}
	}

	@IBAction func segControlAction(_ sender: UISegmentedControl) {
		switch loginSegmentedControl.selectedSegmentIndex {
		case 0:
            LoginViewController.isVendor = false
		case 1:
            LoginViewController.isVendor = true
		default:
			break
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
