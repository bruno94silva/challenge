//
//  RegisterPresenterTest.swift
//  ChallengeTests
//
//  Created by Bruno dos Santos Silva on 07/08/21.
//

import Foundation
import XCTest
@testable import Challenge

class RegisterPresenterTest: XCTestCase {
    
    var registerPresenter: RegisterPresenter?
    
    override func setUpWithError() throws {
        registerPresenter = RegisterPresenter()
    }
    
    func testRegisterSuccess() {
        let myExpectation = self.expectation(description: "valid register success")
        
        registerPresenter!.register(fullName: "Bruno Silva", email: "94bruno.silva@gmail.com", cpf: "42587366860", phoneNumber: "11945339755", password: "BrunoSilva94", confirmPassword: "BrunoSilva94", emailUpdate: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            
            XCTAssert(self.registerPresenter!.statusCodeRegister == "200")
            
            myExpectation.fulfill()
        }

        waitForExpectations(timeout: 6, handler: nil)
    }
    
    override func tearDownWithError() throws {
        registerPresenter = nil
    }
}
