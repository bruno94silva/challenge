//
//  ChallengeUITests.swift
//  ChallengeUITests
//
//  Created by Bruno dos Santos Silva on 07/08/21.
//

import XCTest

class ChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegisterUserAndLoginAndLogout() throws {

        let app = XCUIApplication()
        app.launch()
                  
        app.buttons["REGISTRE-SE"].tap()
        
        app.textFields["Nome Completo"].tap()
        app.textFields["Nome Completo"].typeText("Bruno Silva")
        
        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"next\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.textFields["E-mail"].typeText("94bruno.silva@gmail.com")
        
        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"next\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.textFields["CPF"].typeText("42587366860")
        
        app.textFields["Celular"].tap()
        app.textFields["Celular"].typeText("11945339755")
        
        app.secureTextFields["Senha"].tap()
        
        sleep(2)
        
        app.secureTextFields["Senha"].typeText("BrunoSilva94")
                
        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"next\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.secureTextFields["Confirmação de Senha"].typeText("BrunoSilva94")
        
        app/*@START_MENU_TOKEN@*/.buttons["continue"]/*[[".keyboards.buttons[\"continue\"]",".buttons[\"continue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
        app.buttons["REGISTRAR"].tap()
        
        sleep(5)
        
        if app.alerts.element.collectionViews.buttons["Ok"].exists {
            app.alerts.element.collectionViews.buttons["Ok"].tap()
        }
        
        app.buttons["LOGIN"].tap()
        
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("94bruno.silva@gmail.com")

        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"seguinte\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.secureTextFields["Senha"].typeText("BrunoSilva94")

        app/*@START_MENU_TOKEN@*/.buttons["continue"]/*[[".keyboards.buttons[\"continue\"]",".buttons[\"continue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["LOGIN"].tap()
        
        sleep(5)
        
        if app.buttons["Logout"].exists {
            app.buttons["Logout"].tap()
        }

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
