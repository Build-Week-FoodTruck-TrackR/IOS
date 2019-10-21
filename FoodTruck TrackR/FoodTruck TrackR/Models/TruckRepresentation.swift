//
//  TruckRepresentation.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

struct TruckRepresentation: Codable {
    var location: LocationRepresentaion
    var imageOfTruck: String
    var customerRatings: [CustomerRatingsRepresentaion]
    var customerRatingAvg: Double
}
