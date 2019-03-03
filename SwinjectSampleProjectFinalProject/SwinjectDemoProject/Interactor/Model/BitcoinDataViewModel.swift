//
//  BitcoinDataViewModel.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 21/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

class BitcoinDataViewModel {
    
    // MARK: Private
    private let dollarsDisplayFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = ","
        return formatter
    }()
    
    private let standardFormatter = NumberFormatter()
    
    // MARK: Public
    var price: String
    var cents: String
    
    init(for price: Price) {
        self.price = ""
        self.cents = ""
        
        guard let dollars = price.components().dollars,
            let cents = price.components().cents,
            let dollarAmount = standardFormatter.number(from: dollars) else { return }
        
        self.price = dollarsDisplayFormatter.string(from: dollarAmount) ?? "- - -"
        self.cents = "\(cents)"
    }

}
