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
    var consumer: ConsumerRepresentation?
    var vendor: VendorRepresentation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        consumer = ConsumerController.shared.user as? ConsumerRepresentation
        vendor = VendorController.shared.user as? VendorRepresentation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
        usernameTextfield.text = "brybry"
               emailTextfield.text = "Test@gmail.com"
               nameTextfield.text = "Brian vilchez"
    }
    private func updateViews() {
        guard isViewLoaded else { return }
        if LoginViewController.isVendor {
            guard let vendor = vendor else { return }
            usernameTextfield.text = vendor.username
            emailTextfield.text = vendor.email
            nameTextfield.text = "brian"
        } else {
            guard let consumer = consumer else { return }
            usernameTextfield.text = consumer.username
                     emailTextfield.text = consumer.email
                     nameTextfield.text = "brian"
        }
        usernameTextfield.text = "brybry"
        emailTextfield.text = "Test@gmail.com"
        nameTextfield.text = "Brian vilchez"
    }
    
    @IBAction func signoutButton(_ sender: UIButton) {
        VendorController.shared.token = nil
        ConsumerController.shared.token = nil
        tabBarController?.selectedIndex = 0
        //performSegue(withIdentifier: "LoginSegue", sender: self)
    }
}
