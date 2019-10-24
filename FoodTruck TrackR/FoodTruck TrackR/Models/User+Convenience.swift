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
    convenience init(username: String,
                     password: String,
                     context: NSManagedObjectContext =
                     CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.username = username
        self.password = password

    }
}
