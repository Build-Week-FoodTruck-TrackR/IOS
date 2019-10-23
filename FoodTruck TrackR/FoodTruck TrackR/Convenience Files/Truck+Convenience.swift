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
	convenience init(truckName: String, customerAvgRating: Double, location: Location, imageOfTruck: String, identifier: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

		self.truckName = truckName
        self.imageOfTruck = imageOfTruck
		self.customerAvgRating = customerAvgRating
        self.location = location
        self.identifier = identifier
    }
    
    convenience init(truck: TruckRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(truckName: truck.truckName, customerAvgRating: truck.customerAvgRating, location: Location(location: truck.location), imageOfTruck: truck.imageOfTruck, context: context)
    }
}
