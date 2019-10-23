//
//  VendorRepresentation.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

struct VendorRepresentation: Codable {
    var username: String
    var password: String
    var email: String
    var ownedTrucks: [TruckRepresentation]
    var token: String?
}

struct ReturnedLoginVendor: Codable {
    var username: String
    var password: String
    var email: String
    var id: Int
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
