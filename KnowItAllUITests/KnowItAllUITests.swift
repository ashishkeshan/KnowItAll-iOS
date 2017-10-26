//
//  KnowItAllUITests.swift
//  KnowItAllUITests
//
//  Created by Ashish Keshan on 10/25/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import XCTest

class KnowItAllUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSignOut() {
                // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("shuzawa@usc.edu")

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        app.buttons["Login"].tap()
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Sign Out"]/*[[".cells.staticTexts[\"Sign Out\"]",".staticTexts[\"Sign Out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Are you sure you want to sign out?"].buttons["Yes"].tap()
    }
    
    func testChangePassword() {
        
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("shuzawa@usc.edu")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let settingsButton = app.tabBars.buttons["Settings"]
        settingsButton.tap()
        
        let tablesQuery = app.tables
        let changePasswordStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Change Password"]/*[[".cells.staticTexts[\"Change Password\"]",".staticTexts[\"Change Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        changePasswordStaticText.tap()
        
        let oldPasswordSecureTextField = app.secureTextFields["Old Password"]
        oldPasswordSecureTextField.tap()
        oldPasswordSecureTextField.typeText("12345")
        
        let newPasswordSecureTextField = app.secureTextFields["New Password"]
        newPasswordSecureTextField.tap()
        newPasswordSecureTextField.typeText("1234")
        
        let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.typeText("1234")
        
        let changePasswordButton = app.buttons["Change Password"]
        changePasswordButton.tap()
        
        let doneButton = app.alerts["Success"].buttons["Done"]
        doneButton.tap()
        
        let settingsButton2 = app.navigationBars["Change Password"].buttons["Settings"]
        settingsButton2.tap()
        
        let signOutStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Sign Out"]/*[[".cells.staticTexts[\"Sign Out\"]",".staticTexts[\"Sign Out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        signOutStaticText.tap()
        
        let yesButton = app.sheets["Are you sure you want to sign out?"].buttons["Yes"]
        yesButton.tap()
        emailTextField.tap()
        emailTextField.typeText("shuzawa@usc.edu")
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("1234")
        loginButton.tap()
        settingsButton.tap()
        changePasswordStaticText.tap()
        oldPasswordSecureTextField.tap()
        oldPasswordSecureTextField.typeText("1234")
        newPasswordSecureTextField.tap()
        newPasswordSecureTextField.tap()
        newPasswordSecureTextField.typeText("12345")
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.typeText("12345")
        changePasswordButton.tap()
        doneButton/*@START_MENU_TOKEN@*/.press(forDuration: 0.6);/*[[".tap()",".press(forDuration: 0.6);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        settingsButton2.tap()
        signOutStaticText.tap()
        yesButton.tap()
    }
    
}
