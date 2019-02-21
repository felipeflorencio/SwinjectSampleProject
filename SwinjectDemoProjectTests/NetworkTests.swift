//
//  NetworkTests.swift
//  SwinjectDemoProjectTests
//
//  Created by Felipe Florencio Garcia on 21/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration
@testable import SwinjectDemoProject

class NetworkTests: XCTestCase {

    private let container = Container()
    
    override func setUp() {
        super.setUp()
        container.autoregister(Networking.self,
                               argument: String.self,
                               initializer: MockNetworking.init)
        
        DataSet.all.forEach { dataSet in
            container.register(BitcoinService.self, name: dataSet.name) { resolver in
                let networking = resolver ~> (Networking.self, argument: dataSet.filename)
                return BitcoinService(networking: networking)
            }
        }
    }

    override func tearDown() {
        super.tearDown()
        container.removeAll()
    }
    
    func testDatasetOne() {
        let fetcher = container ~> (BitcoinService.self, name: DataSet.one.name)
        let expectation = XCTestExpectation(description: "Fetch Bitcoin price from dataset one")
        
        fetcher.fetch { response in
            XCTAssertEqual("100000.01", response!.data.amount)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDatasetTwo() {
        let fetcher = container ~> (BitcoinService.self, name: DataSet.two.name)
        let expectation = XCTestExpectation(description: "Fetch Bitcoin price from dataset two")
        
        fetcher.fetch { response in
            XCTAssertEqual("9999999.76", response!.data.amount)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
