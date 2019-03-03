//
//  BitcoinViewController.swift
//  SwinjectDemoProject
//
//  Created by Felipe Florencio Garcia on 20/02/2019.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import UIKit

class BitcoinViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var checkAgain: UIButton!
    @IBOutlet weak private var primary: UILabel!
    @IBOutlet weak private var partial: UILabel!
    
    // MARK: Public variables
    var bitcoinInteractor: BitcoinInteractorProtocol?
    
    // MARK: Main class
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPrice()
    }

    // MARK: - Actions
    @IBAction private func checkAgainTapped(sender: UIButton) {
        requestPrice()
    }
    
    // MARK: - Private methods
    private func requestPrice() {
        bitcoinInteractor?.requestPrice(response: { [weak self] viewModel in
            self?.updateLabel(price: viewModel)
        })
    }
    
    private func updateLabel(price: BitcoinDataViewModel) {
        primary.text = price.price
        partial.text = ".\(price.cents)"
    }
}

