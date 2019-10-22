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
    convenience init(username: String, password: String, email: String, favoriteTrucks: [Truck], context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
		let favoriteTrucksSet = NSOrderedSet(object: favoriteTrucks)
        
        self.username = username
        self.password = password
        self.email = email
		self.favoriteTrucks = favoriteTrucksSet
    }
    
    convenience init(user: ConsumerRepresentation) {
        var trucks: [Truck] = []
        for truck in user.favoriteTrucks {
            trucks.append(Truck(truck: truck))
        }
        
        self.init(username: user.username, password: user.password, email: user.email, favoriteTrucks: trucks)
    }
}
