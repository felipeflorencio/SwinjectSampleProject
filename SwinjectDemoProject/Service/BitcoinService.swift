//
//  BitcoinService.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 20/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

protocol PriceFetcher {
    func fetch(response: @escaping (PriceResponseModel?) -> Void)
}

struct BitcoinService: PriceFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func fetch(response: @escaping (PriceResponseModel?) -> Void) {
        networking.request(from: BitcoinServiceConfiguration.bitcoin) { data, error in
            if let error = error {
                print("Error received requesting Bitcoin price: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: PriceResponseModel.self, from: data)
            if let decoded = decoded {
                print("Price returned: \(decoded.data.amount)")
            }
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        
        return response
    }
}
