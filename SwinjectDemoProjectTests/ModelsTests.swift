//
//  ModelsTests.swift
//  SwinjectDemoProjectTests
//
//  Created by Felipe Florencio Garcia on 21/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration

@testable import SwinjectDemoProject

// Autoregister can handle PriceResponse and Price as long as there are no optionals in the initializer.
// So for this we use this extension in order to make sure that we always have a value
extension PriceResponseModel {
    init(data: Price) {
        self.init(data: data, warnings: nil)
    }
}

extension Price {
    init(amount: String) {
        self.init(base: .BTC, amount: amount, currency: .USD)
    }
}

class ModelsTests: XCTestCase {
    
    private let container = Container()
    
    override func setUp() {
        super.setUp()
        container.autoregister(Price.self,
                               argument: String.self,
                               initializer: Price.init(amount: ))
        
        container.autoregister(PriceResponseModel.self,
                               argument: Price.self,
                               initializer: PriceResponseModel.init(data: ))
        
        container.autoregister(BitcoinDataViewModel.self,
                               argument: Price.self,
                               initializer: BitcoinDataViewModel.init(for: ))
    }
    
    override func tearDown() {
        super.tearDown()
        container.removeAll()
    }
    
    // MARK: - Tests
    
    func testPriceResponseData() {
        let price = container ~> (Price.self, argument: "789654") // container.resolve(Price.self, argument: "789654")!
        let response = container ~> (PriceResponseModel.self, argument: price)
        XCTAssertEqual(response.data.amount, "789654")
    }
    
    func testPrice() {
        let price = container ~> (Price.self, argument: "999456")
        XCTAssertEqual(price.amount, "999456")
    }
    
    func testBitCoinDataViewModel() {
        let price = container ~> (Price.self, argument: "999456")
        let viewModel = container ~> (BitcoinDataViewModel.self, argument: price)
        XCTAssertEqual(viewModel.price, "999,456")
        XCTAssertEqual(viewModel.cents, "999456")
    }
}
