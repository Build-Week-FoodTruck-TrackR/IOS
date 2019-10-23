//
//  Location+Convenience.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData

extension Location {
    convenience init(longitude: Double,
                     latitude: Double,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

        self.longitude = longitude
        self.latitude = latitude
    }
    
    convenience init(location: LocationRepresentaion) {
        self.init(longitude: location.longitute, latitude: location.latitude)
    }
}
