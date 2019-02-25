//
//  BitcoinInteractor.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 20/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

protocol BitcoinInteractorProtocol {
    var fetcher: PriceFetcher { get }
    func requestPrice(response data: @escaping (BitcoinDataViewModel) -> ())
}

class BitcoinInteractor: BitcoinInteractorProtocol {
    
    var fetcher: PriceFetcher
    
    required init(fetcher layer: PriceFetcher) {
        fetcher = layer
    }
    
    func requestPrice(response data: @escaping (BitcoinDataViewModel) -> ()) {
        fetcher.fetch { response in
            guard let response = response else { return }
            DispatchQueue.main.async {
                data(BitcoinDataViewModel(for: response.data))
            }
        }
    }
}
