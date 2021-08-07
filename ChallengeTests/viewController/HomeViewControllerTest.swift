//
//  HomeViewControllerTest.swift
//  ChallengeTests
//
//  Created by Bruno dos Santos Silva on 07/08/21.
//

import Foundation
import XCTest
@testable import Challenge

class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController?
    
    override func setUpWithError() throws {

        let user = User()
        user.name = "Bruno Silva"
        let mobileSession = MobileSession()
        mobileSession.user = user
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "homeViewController") as? HomeViewController
        sut?.mobileSession = mobileSession
        sut?.loadView()
        sut?.viewDidLoad()
    }
    
    func testLoadView() {
        
        let userName = sut!.lblUser.text!
        
        XCTAssertEqual(userName, "Bruno Silva")
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
}
