//
//  CounterTests.swift
//  CounterTests
//
//  Created by Ilya on 22.10.20.
//

import XCTest
@testable import Counter

class CounterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeCounter() throws {
        let counterArray = PreviewBuilder.getCounter()
        
        XCTAssertTrue(counterArray.count == 1)
        
        let counter = counterArray.first
        XCTAssertTrue(counter?.organizationUnitID == 30194)
        XCTAssertTrue(counter?.personCount == 15)
        XCTAssertTrue(counter?.maxPersonCount == 120)
    }

}
