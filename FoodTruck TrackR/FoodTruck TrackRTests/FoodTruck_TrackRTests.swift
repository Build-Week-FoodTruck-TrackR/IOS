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
    
    func testLogInAsConsumer() {
        XCTAssertNil(ConsumerController.shared.user)
        let user = ConsumerLogin(username: "jordan", password: "pass")
        ConsumerController.shared.logIn(user: user) { error in
            if let error = error {
                print(error)
            } else {
                XCTAssertEqual(ConsumerController.shared.user?.username, user.username)
                XCTAssertEqual(ConsumerController.shared.user?.password, user.password)
                
            }
        }
    }
    
    func testLogInAsVendor() {
        XCTAssertNil(VendorController.shared.user)
        let user = VendorLogin(username: "vendor", password: "pass")
        VendorController.shared.logIn(user: user) { error in
            if let error = error {
                print(error)
            } else {
                XCTAssertEqual(VendorController.shared.user?.username, user.username)
                XCTAssertEqual(VendorController.shared.user?.password, user.password)
            }
        }
    }
    
    func testLogInAsConsumerWithBadCredentials() {
        XCTAssertNil(ConsumerController.shared.user)
        ConsumerController.shared.logIn(user: ConsumerLogin(username: "ahfiagr", password: "asouhgou")) { error in
            if let error = error {
                print(error)
            } else {
                XCTAssertNil(ConsumerController.shared.user)
            }
        }
    }
    
    func testLogInAsVendorWithBadCredentials() {
        XCTAssertNil(VendorController.shared.user)
        VendorController.shared.logIn(user: VendorLogin(username: "thisAccount", password: "doesn'tExist")) { error in
            if let error = error {
                print(error)
            } else {
                XCTAssertNil(VendorController.shared.user)
            }
        }
    }
    
    func testSignUpAsConsumer() {
        XCTAssertNil(ConsumerController.shared.user)
        let user = ConsumerSignup(username: "newConsumer", password: "password", email: "consumer@consumerTest.com")
        ConsumerController.shared.register(user: user) { error in
            if let error = error {
                print(error)
            } else {
                XCTAssertEqual(ConsumerController.shared.user?.username, user.username)
                XCTAssertEqual(ConsumerController.shared.user?.password, user.password)
                XCTAssertEqual(ConsumerController.shared.user?.email, user.email)
            }
        }
    }
    
    func testSignUpAsVendor() {
        XCTAssertNil(VendorController.shared.user)
        let user = VendorSignup(username: "newVendor", password: "password", email: "vendor@vendorTest.com")
        VendorController.shared.register(user: user) { error in
            if let error = error {
                print(error)
            } else {
                XCTAssertEqual(VendorController.shared.user?.username, user.username)
                XCTAssertEqual(VendorController.shared.user?.password, user.password)
                XCTAssertEqual(VendorController.shared.user?.email, user.email)
            }
        }
    }
    
    func testSearch() {
        var trucks = [TruckRepresentation]()
        
        TruckController.shared.fetchTrucksFromServer { error in
            if let error = error {
                print(error)
            } else {
                trucks = TruckController.shared.getTrucks(with: "Ice")
                XCTAssertFalse(trucks.isEmpty)
            }
        }
    }
    
    func testSignOut() {
        let user = ConsumerLogin(username: "jordan", password: "pass")
        ConsumerController.shared.logIn(user: user) { error in
            if let error = error {
                print(error)
            } else {
                XCTAssertNotNil(ConsumerController.shared.user)
                XCTAssertEqual(ConsumerController.shared.user?.password, user.password)
                
                VendorController.shared.logOut()
                ConsumerController.shared.logOut()
                
                XCTAssertNil(ConsumerController.shared.user)
            }
        }
    }
}
