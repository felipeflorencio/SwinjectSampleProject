//
//  BitcoinServiceConfiguration.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 20/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

enum BitcoinServiceConfiguration {
    case bitcoin
}

extension BitcoinServiceConfiguration: Endpoint {
    var path: String {
        switch self {
        case .bitcoin: return "https://api.coinbase.com/v2/prices/BTC-USD/spot"
        }
    }
}
