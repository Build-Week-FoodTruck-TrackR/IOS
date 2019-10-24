//
//  APIController.swift
//  FoodTruck TrackR
//
//  Created by brian vilchez on 10/23/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation


class APICOntroller {
    
    
    func registerUser(withEmail email: String, password: String, username: String, userType: UserType) {
        
        let firebase = baseURL
        
        switch userType {
        case .consumer:
            ConsumerController.shared.register(user: ConsumerSignup(username: username, password: password, email: email)) { (error) in
                if let error = error {
                    NSLog("error: \(error)")
                }
            }
            
    firebase.appendingPathComponent("consumer")
            .appendingPathComponent(username)
             .appendingPathExtension("json")
            
        case .vendor:
            VendorController.shared.register(user: VendorSignup(username: username, password: password, email: email )) { (error) in
                  if let error = error {
                    NSLog("error: \(error)")
                }
            }
            
    firebase.appendingPathComponent("vendor")
            .appendingPathComponent(username)
            .appendingPathExtension("json")
       
        }
       
    }
    
    
    
    
    
    
}
