//
//  User.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/19/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData

extension Consumer {
    convenience init(username: String, password: String, favoriteTrucks: [Truck] ,context: NSManagedObjectContext = CoreDataStack.shared.mainContext) { // These are just some variables I assume will be in the actual model. Feel free to change, add, or delete how ever you like
        self.init(context: context)
		let favoriteTrucksSet = NSOrderedSet(object: favoriteTrucks)
        
        self.username = username
        self.password = password
		self.favoriteTrucks = favoriteTrucksSet
    }
}
