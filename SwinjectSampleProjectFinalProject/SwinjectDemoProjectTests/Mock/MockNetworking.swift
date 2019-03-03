//
//  MockNetworking.swift
//  SwinjectDemoProjectTests
//
//  Created by Felipe Florencio Garcia on 21/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import XCTest
import Foundation
@testable import SwinjectDemoProject

struct MockNetworking: Networking {
    let filename: String
    
    func request(from: Endpoint, completion: @escaping CompletionHandler) {
        let data = readJSON(name: filename)
        completion(data, nil)
    }
    
    private func readJSON(name: String) -> Data? {
        let bundle = Bundle(for: NetworkTests.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else { return nil }
        
        do {
            return try Data(contentsOf: url, options: .mappedIfSafe)
        }
        catch {
            XCTFail("Error occurred parsing test data")
            return nil
        }
    }
}

enum DataSet: String {
    case one
    case two
    
    static let all: [DataSet] = [.one, .two]
}

extension DataSet {
    var name: String { return rawValue }
    var filename: String { return "dataset-\(rawValue)" }
}
