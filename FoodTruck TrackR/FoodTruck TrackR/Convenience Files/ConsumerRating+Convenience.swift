//
//  ConsumerRatings+Convenience.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/21/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData

extension ConsumerRating {
    convenience init(consumerRating: Int, comments: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

        self.consumerRating = Int16(consumerRating)
        self.comments = comments
    }
}
