//
//  MenuPhoto+Convenience.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData

extension MenuPhoto {
    convenience init(photoURL: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.photoURL = photoURL
    }
}
