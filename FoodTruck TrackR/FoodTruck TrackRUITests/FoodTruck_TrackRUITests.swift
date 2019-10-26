//
//  FoodTruck_TrackRUITests.swift
//  FoodTruck TrackRUITests
//
//  Created by Jordan Christensen on 10/23/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import XCTest

class FoodTruck_TrackRUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    func testLogIn() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        
        usernameTextField.tap()
        usernameTextField.typeText("jordan")
        
        passwordTextField.tap()
        passwordTextField.typeText("pass")
        
        app.buttons["Log In"].tap()
        
        app.tabBars.buttons["gear"].tap()
        app.buttons["eye"].tap()
        
        XCTAssertEqual(app.textFields["Settings.UsernameTextField"].value as? String, "jordan")
        XCTAssertEqual(app.textFields["Settings.EmailTextField"].value as? String, "jordan@email.com")
    }
    
    func testLogOut() {
        testLogIn()
        XCTAssertNotNil(app.textFields["Username"].value as? String)
        
        app.staticTexts["Sign out"].tap()
        
//        XCTAssertNil(ConsumerController.shared.user)
//        XCTAssertNil(VendorController.shared.user)
    }
    
    func testSignUp() {
        app.staticTexts["Don't have an account yet? Sign up here!"].tap()
        
        
    }
}
