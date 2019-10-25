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
    @IBOutlet private weak var nameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signoutButton(_ sender: UIButton) {
        unwind(for: <#UIStoryboardSegue#>, towards: LoginViewController())
    }
    

}
