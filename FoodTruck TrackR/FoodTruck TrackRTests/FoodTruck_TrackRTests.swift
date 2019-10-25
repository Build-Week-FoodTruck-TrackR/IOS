//
//  FoodTruck_TrackRTests.swift
//  FoodTruck TrackRTests
//
//  Created by Jordan Christensen on 10/23/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import XCTest
@testable import FoodTruck_TrackR

class FoodTruck_TrackRTests: XCTestCase {

    func testAddNewTruck() {
        super.setUp()
        var count = 0
        TruckController.shared.fetchTrucksFromServer { error in
            if let error = error {
                print(error)
            } else {
                count = TruckController.shared.trucks.count
            }
        }
        
        TruckController.shared.createTruck(with: "Test truck", location: Location(longitude: 100, latitude: 100), imageOfTruck: "")
        XCTAssertEqual(count, TruckController.shared.trucks.count)
    }
    
    func testDeleteTruck() {
        var count = 0
        TruckController.shared.fetchTrucksFromServer { error in
            if let error = error {
                print(error)
            } else {
                count = TruckController.shared.trucks.count
                TruckController.shared.deleteTruckFromServer(truck: TruckController.shared.trucks[TruckController.shared.trucks.count - 1])
                
                XCTAssertEqual(count, TruckController.shared.trucks.count)
            }
        }
    }
    
    func testSignUp() {
        
    }
}
