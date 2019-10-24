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
    var customerAvgRating: Double
	var truckName: String
    var identifier: UUID

	init(location: LocationRepresentaion = LocationRepresentaion(longitute: 0.0, latitude: 0.0),
         imageOfTruck: String = "",
         customerAvgRating: Double = 0.0,
         truckName: String = "",
         identifier: UUID = UUID()) {

		self.location = location
		self.imageOfTruck = imageOfTruck
		self.customerAvgRating = customerAvgRating
		self.truckName = truckName
		self.identifier = identifier
	}
}
