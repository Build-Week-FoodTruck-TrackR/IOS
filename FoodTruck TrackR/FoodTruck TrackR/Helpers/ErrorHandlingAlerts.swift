//
//  ErrorHandlingAlerts.swift
//  FoodTruck TrackR
//
//  Created by brian vilchez on 10/24/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import UIKit

enum UserAlert {
    
    static func showLoginAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: "Unable to login", message: "Please check your username and password and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showSignupAlert(on viewController: UIViewController) {
          let alert = UIAlertController(title: "Sign Up Error", message: "Unable to signup at this moment please try again", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          DispatchQueue.main.async {
              viewController.present(alert, animated: true, completion: nil)
          }
      }
}
