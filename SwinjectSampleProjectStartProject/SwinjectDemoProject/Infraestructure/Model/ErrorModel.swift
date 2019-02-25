//
//  ErrorModel.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 20/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

struct Error: Codable {
    let id: String
    let message: String
    let url: String
}
