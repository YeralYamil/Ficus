//
//  CarCellViewModelTests.swift
//  FicusTests
//
//  Created by Yeral Yamil on 7/29/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import XCTest
@testable import Ficus

class CarCellViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_SetsCarAndElectricityPriceDetail() {
        
    }
    
    func createCar() -> Car {
        let jsonString = "[\"carCategory\": [\"id\": \"cjjevl6f1x19d0177drgqk51e\", \"name\": \"Compact\", \"__typename\": \"CarCategory\"], \"comparisonText\": \"Honda Civic or similar\", \"efficiency\": 7.4000000000000004, \"__typename\": \"Car\", \"efficiencyType\": \"LP100km\", \"type\": \"Gas\"]"
        let jsonData = jsonString.data(using: .utf8)
        let dictionary = try! JSONSerialization.jsonObject(with: jsonData!, options: .mutableLeaves) as! Dictionary<String, Any>
        
        return Car.init(unsafeResultMap: dictionary)
    }
    
}
