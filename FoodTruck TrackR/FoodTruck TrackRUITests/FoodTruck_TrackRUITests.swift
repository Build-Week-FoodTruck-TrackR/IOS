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
    
    func testLogOutAndLogBackIn() {
        testLogIn()
        XCTAssertNotNil(app.textFields["Username"].value as? String)
        
        app.staticTexts["Sign out"].tap()
        
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        
        usernameTextField.tap()
        usernameTextField.typeText("brybry")
        
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        app.buttons["Log In"].tap()
        
        app.tabBars.buttons["gear"].tap()
        
        XCTAssertEqual(app.textFields["Settings.UsernameTextField"].value as? String, "brybry")
        XCTAssertEqual(app.textFields["Settings.EmailTextField"].value as? String, "test@gmail.com")
    }
    
    func testSignUp() {
        app.staticTexts["Don't have an account yet? Sign up here!"].tap()
        
        let email = app.textFields["Email"]
        let username = app.textFields["Username"]
        let password = app.secureTextFields["Password"]
        
        let emailText = "testing@app.com"
        let usernameText = "testingApp"
        
        email.tap()
        email.typeText(emailText)
        username.tap()
        username.typeText(usernameText)
        password.tap()
        password.typeText("pass")
        
        app.buttons["Sign Up Here"].tap()
        
        app.tabBars.buttons["gear"].tap()
        app.buttons["Settings.Eye"].tap()
        
        XCTAssertEqual(app.textFields["Settings.UsernameTextField"].value as? String, usernameText)
        XCTAssertEqual(app.textFields["Settings.EmailTextField"].value as? String, emailText)
    }
    
    func testSearch() {
        let usernameTextField = app.textFields["Username"]
        let passwordTextField = app.secureTextFields["Password"]
        
        usernameTextField.tap()
        usernameTextField.typeText("jordan")
        
        passwordTextField.tap()
        passwordTextField.typeText("pass")
        
        app.buttons["Log In"].tap()
        
        let searchBar = app.searchFields["Search Food Trucks"]
        searchBar.tap()
        searchBar.typeText("Ice\n")
        
        let firstCell = app.tables["searchResultsTable"].cells["FoodTruckCell0"]
        XCTAssertTrue(firstCell.exists)
    }
}
