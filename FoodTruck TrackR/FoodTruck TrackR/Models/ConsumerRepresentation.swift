//
//  User+Representation.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/19/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

struct ConsumerRepresentation: Codable {
    var username: String
    var password: String
    var email: String
    var currentLocation: LocationRepresentaion
    var favoriteTrucks: [TruckRepresentation]
}

struct ReturnedConsumer: Codable {
    var user: ReturnedUser
    var token: String?
}

struct ReturnedUser: Codable {
    var username: String
    var id: Int
}

struct ConsumerLogin: Codable { // To log in the user only needs to input a username and password
    var username: String
    var password: String
}

struct ConsumerSignup: Codable { // To sign up the user needs to put in a username, password, and email
    var username: String
    var password: String
    var email: String
}
