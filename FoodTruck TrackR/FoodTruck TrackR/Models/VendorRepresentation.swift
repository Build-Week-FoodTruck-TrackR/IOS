//
//  VendorRepresentation.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import FirebaseDatabase

class VendorRepresentation: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case ownedTrucks
        case identifier
    }

    var username: String
    var email: String
    var ownedTrucks: [TruckRepresentation]
    var identifier: String

    init(username: String, password: String, email: String, ownedTrucks: [TruckRepresentation], identifier: String) {
        self.username = username
        self.email = email
        self.ownedTrucks = ownedTrucks
        self.identifier = identifier
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let username = try container.decode(String.self, forKey: .username)
        let email = try container.decode(String.self, forKey: .email)
        let trucksDict = try container.decodeIfPresent([String: TruckRepresentation].self, forKey: .ownedTrucks)
        var trucks: [TruckRepresentation] = []
        if let temp = trucksDict {
            trucks = Array(temp.values)
        }
        let identifier = try container.decode(String.self, forKey: .identifier)
        
        self.username = username
        self.email = email
        self.ownedTrucks = trucks
        self.identifier = identifier
    }
    
    static func == (lhs: VendorRepresentation, rhs: VendorRepresentation) -> Bool {
        return lhs.username == rhs.username &&
            lhs.email == rhs.email &&
            lhs.identifier == rhs.identifier
    }
}
