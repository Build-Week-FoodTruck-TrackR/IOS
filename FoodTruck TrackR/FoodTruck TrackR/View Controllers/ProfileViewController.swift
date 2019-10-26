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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LoginViewController.isVendor {
            let vendor: VendorRepresentation? = VendorController.shared.user
            usernameTextfield.text = vendor?.username
            emailTextfield.text = vendor?.email
        } else {
            let consumer: ConsumerRepresentation? = ConsumerController.shared.user
            usernameTextfield.text = consumer?.username
            emailTextfield.text = consumer?.email
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
