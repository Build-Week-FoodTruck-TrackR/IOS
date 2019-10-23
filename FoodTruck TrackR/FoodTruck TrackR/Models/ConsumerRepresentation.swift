//
//  User+Representation.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/19/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

class ConsumerRepresentation: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case email
        case favoriteTrucks
        case identifier
        case currentLocation
    }

    var username: String
    var password: String
    var email: String
    var currentLocation: LocationRepresentaion
    var favoriteTrucks: [TruckRepresentation]
    var identifier: UUID

    init(username: String, password: String, email: String, currentLocation: LocationRepresentaion, favoriteTrucks: [TruckRepresentation], identifier: UUID) {
        self.username = username
        self.password = password
        self.email = email
        self.currentLocation = currentLocation
        self.favoriteTrucks = favoriteTrucks
        self.identifier = identifier
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let username = try container.decode(String.self, forKey: .username)
        let password = try container.decode(String.self, forKey: .password)
        let email = try container.decode(String.self, forKey: .email)
        let location = try container.decode([String: Double].self, forKey: .currentLocation).map { $0.value }
        let currentLocation: LocationRepresentaion
        if location.count == 2 {
            currentLocation = LocationRepresentaion(longitute: location[0], latitude: location[1])
        } else {
            currentLocation = LocationRepresentaion(longitute: 0, latitude: 0)
        }
        let trucksDict = try container.decodeIfPresent([String: TruckRepresentation].self, forKey: .favoriteTrucks)
        var trucks: [TruckRepresentation] = []
        if let temp = trucksDict {
            trucks = Array(temp.values)
        }
        let identifier = try container.decode(String.self, forKey: .identifier)
        guard let id = UUID(uuidString: identifier) else { throw NSError() }
        
        self.username = username
        self.password = password
        self.email = email
        self.favoriteTrucks = trucks
        self.currentLocation = currentLocation
        self.identifier = id
    }
    
    static func == (lhs: ConsumerRepresentation, rhs: ConsumerRepresentation) -> Bool {
        return lhs.username == rhs.username &&
            lhs.password == rhs.password &&
            lhs.email == rhs.email &&
            lhs.identifier == rhs.identifier
    }
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
