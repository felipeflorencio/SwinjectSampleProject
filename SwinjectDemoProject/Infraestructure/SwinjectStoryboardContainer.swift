//
//  SwinjectStoryboardContainer.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 21/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    @objc class func setup() {
        let mainContainer = MainContainer.sharedContainer.container
        
        defaultContainer.storyboardInitCompleted(BitcoinViewController.self) { _, controller in
            controller.bitcoinInteractor = mainContainer.resolve(BitcoinInteractorProtocol.self)
        }
    }
}
