//
//  StringTest.swift
//  ChallengeTests
//
//  Created by Bruno dos Santos Silva on 06/08/21.
//

import Foundation
import XCTest
@testable import Challenge

class StringTest: XCTestCase {
        
    func testIsValidEmail() {
        let email: String = "test@test2.com"
        
        XCTAssertTrue(email.isValidEmail())
    }
    
    func testIsTwoWordsOrMore() {
        let twoWordsOrMore = "Bruno dos Santos Silva"
        
        XCTAssertTrue(twoWordsOrMore.isTwoWordsOrMore())
    }
    
    func testIsValidPassword() {
        let password = "BrunoSilva94"
        
        XCTAssertTrue(password.isValidPassword())
    }
}
