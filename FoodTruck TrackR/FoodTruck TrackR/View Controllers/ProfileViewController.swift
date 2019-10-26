//
//  ProfileViewController.swift
//  FoodTruck TrackR
//
//  Created by brian vilchez on 10/24/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var usernameTextfield: UITextField!
    @IBOutlet private weak var emailTextfield: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var eyeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LoginViewController.isVendor {
            let vendor: VendorRepresentation? = VendorController.shared.user
            usernameTextfield.text = vendor?.username
            emailTextfield.text = vendor?.email
            passwordTextField.text = vendor?.password
        } else {
            let consumer: ConsumerRepresentation? = ConsumerController.shared.user
            usernameTextfield.text = consumer?.username
            emailTextfield.text = consumer?.email
            passwordTextField.text = consumer?.password
        }
    }
    
    func setupViews() {
        let navBarAppearance = UINavigationBarAppearance()
        view.backgroundColor = UIColor.titleBarColor
        
        tabBarController?.tabBar.barStyle = .default
        tabBarController?.tabBar.barTintColor = UIColor.titleBarColor
        tabBarController?.tabBar.tintColor = UIColor.textWhite

        usernameLabel.textColor = .white
        emailLabel.textColor = .white
        passwordLabel.textColor = .white
        passwordTextField.isSecureTextEntry = true
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.backgroundColor = UIColor.titleBarColor

        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor.titleBarColor
        navigationController?.navigationBar.backgroundColor = UIColor.titleBarColor

        navigationController?.navigationBar.tintColor = UIColor.textWhite
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
        self.navigationController?.navigationBar.barTintColor = UIColor.titleBarColor
        self.navigationController?.navigationBar.tintColor = UIColor.textWhite
        
        
    }
    
    @IBAction func viewHidePassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        if passwordTextField.isSecureTextEntry {
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @IBAction func signoutButton(_ sender: UIButton) {
        VendorController.shared.token = nil
        VendorController.shared.user = nil
        ConsumerController.shared.token = nil
        ConsumerController.shared.user = nil
        
        tabBarController?.selectedIndex = 0
    }
}
