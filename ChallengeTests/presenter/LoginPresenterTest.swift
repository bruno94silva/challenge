//
//  LoginPresenterTest.swift
//  ChallengeTests
//
//  Created by Bruno dos Santos Silva on 07/08/21.
//

import Foundation
import XCTest
@testable import Challenge

class LoginPresenterTest: XCTestCase {
    
    var loginPresenter: LoginPresenter?
    
    override func setUpWithError() throws {
        loginPresenter = LoginPresenter()
    }
    
    func testLoginSuccess() {
        let myExpectation = self.expectation(description: "valid login success")
        
        loginPresenter!.login(email: "94bruno.silva@gmail.com", password: "BrunoSilva94")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            
            XCTAssert(self.loginPresenter!.statusCodeLogin == "200")
            
            myExpectation.fulfill()
        }

        waitForExpectations(timeout: 6, handler: nil)
    }
    
    override func tearDownWithError() throws {
        loginPresenter = nil
    }
}
