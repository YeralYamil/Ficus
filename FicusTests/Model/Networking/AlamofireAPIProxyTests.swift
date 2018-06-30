//
//  AlamofireAPIProxyTests.swift
//  Ficus
//
//  Created by Yeral Yamil Castillo on 6/30/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import XCTest
@testable import Ficus

class AlamofireAPIProxyTests: XCTestCase {
    
    var sut: AlamofireAPIProxy!
    override func setUp() {
        super.setUp()
        sut = AlamofireAPIProxy()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequest_CallsCompletion() {
        let completionExpectation = XCTestExpectation(description: "completion")
        _ = sut.request(router: MockRouter()) { (APIResponse) in
            completionExpectation.fulfill()
        }
        
        wait(for: [completionExpectation], timeout: 5)
    }
}

class MockRouter: APIRouter {
    var baseUrl: String = ""
    
    func asURLRequest() throws -> URLRequest {
        throw ServiceError.custom("Not Implemented")
    }    
}
