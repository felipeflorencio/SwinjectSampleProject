//
//  PriceResponseModel.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 20/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

struct PriceResponseModel: Codable {
    let data: Price
    let warnings: [Error]?
}

enum Currency: String, Codable {
    case USD
}

enum CryptoCurrency: String, Codable {
    case BTC
}

struct Price: Codable {
    let base: CryptoCurrency
    let amount: String
    let currency: Currency
}

extension Price {
    func components() -> (dollars: String?, cents: String?) {
        let tokens = amount.components(separatedBy: ".")
        return (dollars: tokens.first, cents: tokens.last)
    }
}
