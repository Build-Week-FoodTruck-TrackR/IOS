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
	convenience init(customerAvgRating: Int, location: Location, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)


		self.customerAvgRating = Int16(customerAvgRating)
        self.location = location
    }
}
