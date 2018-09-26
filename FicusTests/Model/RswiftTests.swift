//
//  RswiftTests.swift
//  FicusTests
//
//  Created by Yeral Yamil on 9/25/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import XCTest
@testable import Ficus

class RswiftTests: XCTestCase {
    
    func testRswiftIsValid() {
        XCTAssertNoThrow(try R.validate())
    }
    
}
