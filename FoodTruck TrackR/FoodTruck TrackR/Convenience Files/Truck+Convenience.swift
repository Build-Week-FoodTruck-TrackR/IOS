//
//  Truck+Convenience.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/21/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData

extension Truck {
	convenience init(truckName: String,
                     customerAvgRating: Double,
                     location: Location,
                     imageOfTruck: String,
                     cuisineType: String? = nil,
                     identifier: String? = nil,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

		self.truckName = truckName
        self.imageOfTruck = imageOfTruck
		self.customerAvgRating = customerAvgRating
        self.location = location
        self.cuisine = cuisineType
        self.identifier = identifier
    }
    
    convenience init(truck: TruckRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(truckName: truck.truckName,
                  customerAvgRating: truck.customerAvgRating,
                  location: Location(location: truck.location),
                  imageOfTruck: truck.imageOfTruck,
                  context: context)
    }

	var truckRepresentation: TruckRepresentation? {
		guard let location = location,
			let imageOfTruck = imageOfTruck,
			let identifier = identifier,
			let truckName = truckName else { return nil }
		return TruckRepresentation(location: LocationRepresentaion(longitute: location.longitude,
                                                                   latitude: location.latitude),
                                   imageOfTruck: imageOfTruck,
                                   customerAvgRating: customerAvgRating,
                                   truckName: truckName,
                                   identifier: identifier)
	}
}
