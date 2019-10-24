//
//  SignUpViewController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/23/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - properties
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var signUpButtonLabel: UIButton!
	@IBOutlet weak var vendorSwitch: UISwitch!
    
	let vendorController = VendorController.shared
	let consumerController = ConsumerController.shared
    var usertype: UserType?

   // MARK: - lifeCycles
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		// Do any additional setup after loading the view.
	}

    //MARK: - methods
	private func setupViews() {
        usertype = .consumer
		view.backgroundColor = UIColor.titleBarColor
		passwordTextField.isSecureTextEntry = true
		signUpButtonLabel.tintColor = UIColor.textWhite
		navigationController?.navigationBar.barStyle = .default
		navigationController?.navigationBar.tintColor = UIColor.textWhite
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleBarColor]
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleBarColor]
	}

    
    //MARK: - actions
    @IBAction func checkUserType(_ sender: UISwitch) {
        switch vendorSwitch.isOn {
        case true: usertype = .vendor
        case false: usertype = .consumer
        }
    }
    
	@IBAction func signUpTapped(_ sender: UIButton) {
		guard let username = usernameTextField.text,
			let password = passwordTextField.text,
			let email = emailTextField.text else { return }
        guard let usertype = usertype else {return}
        
        switch usertype {
        case .consumer:
            ConsumerController.shared.register(user: ConsumerSignup(username: username, password: password, email: email)) { (error) in
                if let error = error {
                    NSLog("failed to register: \(error)")
                    DispatchQueue.main.async {
                        UserAlert.showSignupAlert(on: self)
                    }
                }
            }
        case .vendor: VendorController.shared.register(user: VendorSignup(username: username, password: password, email: email)) { (error) in
            if let error = error {
                NSLog("failed to register: \(error)")
                DispatchQueue.main.async {
                    UserAlert.showSignupAlert(on: self)
                }
            }
        }
        
        }
	}
}
