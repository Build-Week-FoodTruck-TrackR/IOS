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
    convenience init(username: String, password: String, email: String, trucksOwned: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

        self.username = username
        self.password = password
        self.email = email
		self.trucksOwned = trucksOwned
    }
}
