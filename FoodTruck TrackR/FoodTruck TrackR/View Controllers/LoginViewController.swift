//
//  LoginViewController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/20/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    // MARK: - Properties
    @IBOutlet private weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    static var isVendor: Bool = false
    var userType: UserType?
    let vendorController = VendorController.shared
    let consumerController = ConsumerController.shared
    
    // MARK: - lifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - helper methods
    private func setupViews() {
        userType = .consumer
        view.backgroundColor = UIColor.titleBarColor
        
        passwordTextField.isSecureTextEntry = true
        
        loginSegmentedControl.backgroundColor = UIColor.highLightColor
        
        loginButton.backgroundColor = UIColor.textWhite
        loginButton.setTitleColor(UIColor.background, for: .normal)
        loginButton.layer.cornerRadius = 8
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleBarColor]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleBarColor]
    }
    
    // MARK: - Actions
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,!username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        guard let userType = userType else { return }
        
        switch userType {
        case .vendor:
            vendorController.logIn(user: VendorLogin(username: username, password: password)) { error in
                if let error: NetworkError = error {
                    NSLog("Error returned when trying to log in: \(error)")
                    DispatchQueue.main.async {
                        UserAlert.showLoginAlert(on: self)
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        case .consumer:
            consumerController.logIn(user: ConsumerLogin(username: username, password: password)) { error in
                if let error: NetworkError = error {
                    NSLog("Error returned when trying to log in: \(error)")
                    DispatchQueue.main.async {
                        UserAlert.showLoginAlert(on: self)
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
            userType = .consumer
        case 1:
            LoginViewController.isVendor = true
            userType = .vendor
        default:
            break
        }
    }
}
