//
//  Vendor+Convenience.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/21/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData

extension Vendor {
    convenience init(username: String, password: String, email: String, trucksOwned: [Truck], identifier: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

        self.username = username
        self.password = password
        self.email = email
        self.trucksOwned = NSOrderedSet(object: trucksOwned)
        self.identifier = identifier
    }
    
    convenience init(user: VendorRepresentation) {
        var trucks: [Truck] = []
        for truck in user.ownedTrucks {
            trucks.append(Truck(truck: truck))
        }
        
        self.init(username: user.username, password: user.password, email: user.email, trucksOwned: trucks)
    }
}
