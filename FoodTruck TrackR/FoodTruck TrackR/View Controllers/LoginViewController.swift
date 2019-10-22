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
    var isVendor: Bool = false
    let userController = UserController.shared
    
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
    
    private func logIn() {
//        guard let username = usernameTextField.text,
//              let password = passwordTextField.text else { return }
//        if isVendor {
//            userController.logIn(user: VendorLogin(username: username, password: password) { error in
//                if error == nil {
//                    self.dismiss(animated: true, completion: nil)
//                }
//            })
//        } else {
//            userController.logIn(user: ConsumerLogin(username: username, password: password) { error in
//                if error == nil {
//                    self.dismiss(animated: true, completion: nil)
//                }
//            })
//        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        logIn()
    }
    
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch loginSegmentedControl.selectedSegmentIndex {
        case 0:
            isVendor = false
        case 1:
            isVendor = true
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
