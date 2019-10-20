//
//  LoginViewController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/20/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var LoginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var isLogin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        
        passwordTextField.isSecureTextEntry = true
        
        loginButton.backgroundColor = .text
        loginButton.setTitleColor(UIColor.background, for: .normal)
        loginButton.layer.cornerRadius = 8
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
    }
    
    private func logIn() {
        
        dismiss(animated: true, completion: nil)
    }
    
    private func signUp() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        if isLogin {
            logIn()
        } else {
            signUp()
        }
    }
    
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch LoginSegmentedControl.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.5) {
                self.loginButton.setTitle("Log In", for: .normal)
                self.title = "Log In"
                self.emailTextField.isHidden = true
            }
            isLogin = true
        case 1:
            UIView.animate(withDuration: 0.5) {
                self.loginButton.setTitle("Sign Up", for: .normal)
                self.title = "Sign Up"
                self.emailTextField.isHidden = false
            }
            isLogin = false
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
