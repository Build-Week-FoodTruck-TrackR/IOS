//
//  MenuItem+Convenience.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/21/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData 

extension MenuItems {
	convenience init(itemName: String, itemDescription: String, itemPhotos: [MenuPhotos], itemPrice: Double, consumerRating: [ConsumerRating] ,context: NSManagedObjectContext = CoreDataStack.shared.mainContext) { // These are just some variables I assume will be in the actual model. Feel free to change, add, or delete how ever you like
        self.init(context: context)

        self.itemName = itemName
        self.itemDescription = itemDescription
		self.itemPhotos = NSOrderedSet(object: itemPhotos)
    }
}
