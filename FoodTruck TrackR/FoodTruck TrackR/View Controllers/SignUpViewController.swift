//
//  SignUpViewController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/23/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
	@IBOutlet private weak var emailTextField: UITextField!
	@IBOutlet private weak var usernameTextField: UITextField!
	@IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet private weak var signUpButtonLabel: UIButton!
	@IBOutlet private weak var vendorSwitch: UISwitch!
    
	let vendorController = VendorController.shared
	let consumerController = ConsumerController.shared
    var usertype: UserType?

   // MARK: - lifeCycles
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		// Do any additional setup after loading the view.
	}

    // MARK: - Methods
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

    
    // MARK: - Actions
    @IBAction func checkUserType(_ sender: UISwitch) {
        switch vendorSwitch.isOn {
        case true:
            usertype = .vendor
            LoginViewController.isVendor = true
        case false:
            usertype = .consumer
            LoginViewController.isVendor = false
        }
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
	@IBAction func signUpTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty else { return }
        if !isPasswordValid(password) {
            let alert = UIAlertController(title: "Password isn't valid", message: "Password must contain at least one special character: \"?=.[$@$#!%?&]\"\nPassword must be at least 8 characters\nPassword must contain at least one letter", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let usertype = usertype else { return }
        
        if username.isEmpty {
            UserAlert.showSignupAlert(on: self)
        }
        switch usertype {
        case .consumer:
            ConsumerController.shared.register(username: username, password: password, email: email, firstName: firstName, lastName: lastName) { error in
                if let error = error {
                    NSLog("failed to register: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        UserAlert.showSignupAlert(on: self)
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        case .vendor:
            VendorController.shared.register(username: username, password: password, email: email, firstName: firstName, lastName: lastName) { error in
            if let error = error {
                NSLog("failed to register: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    UserAlert.showSignupAlert(on: self)
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
}
