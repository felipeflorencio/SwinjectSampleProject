//
//  InteractorTests.swift
//  SwinjectDemoProjectTests
//
//  Created by Felipe Florencio Garcia on 21/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration
@testable import SwinjectDemoProject

class InteractorTests: XCTestCase {

    private let container = Container()
    
    override func setUp() {
        super.setUp()
        container.autoregister(Networking.self,
                               argument: String.self,
                               initializer: MockNetworking.init)
        
        container.register(BitcoinService.self, name: DataSet.one.name) { resolver in
            let networking = resolver ~> (Networking.self, argument: DataSet.one.filename)
            return BitcoinService(networking: networking, service: .bitcoin)
        }
        
        container.register(BitcoinInteractorProtocol.self) { resolver in
            let fetcher = resolver ~> (BitcoinService.self, name: DataSet.one.name)
            return BitcoinInteractor(fetcher: fetcher)
        }
    }

    override func tearDown() {
        container.removeAll()
    }
    
    func testRequestPrice() {
        let interactor = container ~> (BitcoinInteractorProtocol.self)
        let expectation = XCTestExpectation(description: "Fetch Bitcoin price from dataset one and generate viewModel")
        
        interactor.requestPrice { viewModel in
            XCTAssertEqual("100,000", viewModel.price)
            XCTAssertEqual("01", viewModel.cents)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

}
