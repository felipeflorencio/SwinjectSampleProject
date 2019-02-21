//
//  NetworkService.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 20/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
}

protocol Networking {
    typealias CompletionHandler = (Data?, Swift.Error?) -> Void
    
    func request(from: Endpoint, completion: @escaping CompletionHandler)
}

struct HTTPNetworking: Networking {

    func request(from: Endpoint, completion: @escaping CompletionHandler) {
        guard let url = URL(string: from.path) else { return }
        let request = createRequest(from: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        return request
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, httpResponse, error in
            completion(data, error)
        }
    }
}
