//
//  User+Representation.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/19/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

struct ConsumerLogin: Codable { // To log in the user only needs to input a username and password
    var username: String
    var password: String
}

struct ConsumerSignup: Codable { // To sign up the user needs to put in a username, password, and email
    var username: String
    var password: String
    var email: String
}

struct VendorLogin: Codable {
    var username: String
    var password: String
}

struct VendorSignup: Codable {
    var username: String
    var password: String
    var email: String
}
