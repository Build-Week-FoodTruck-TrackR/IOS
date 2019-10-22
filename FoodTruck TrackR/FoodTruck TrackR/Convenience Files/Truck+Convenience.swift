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
    convenience init(customerAvgRating: Double, location: Location, imageOfTruck: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

        self.imageOfTruck = imageOfTruck
		self.customerAvgRating = customerAvgRating
        self.location = location
    }
    
    convenience init(truck: TruckRepresentation) {
        self.init(customerAvgRating: truck.customerRatingAvg, location: Location(location: truck.location), imageOfTruck: truck.imageOfTruck)
    }
}
