//
//  TcsNewsTests.swift
//  TcsNewsTests
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import XCTest
@testable import TcsNews

class TcsNewsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Just an example of unit test
    func testExample()
    {
        let singleton1 = TcsServiceManager.sharedInstance
        let singleton2 = TcsServiceManager.sharedInstance

        XCTAssertTrue(singleton1 === singleton2)

        let singleton3 = CoreDataManager.sharedInstance

        XCTAssertTrue(singleton3 !== singleton1)
    }
    

    
}
