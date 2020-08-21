//
//  ViewController.swift
//  LinkedInLoadingView
//
//  Created by Ahmed Khalaf on 8/21/20.
//  Copyright © 2020 io.github.ahmedkhalaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadingView.show(in: view)
    }
    
    private lazy var loadingView: LILoadingView = {
        let loadingView = LILoadingView(frame: .zero)
        loadingView.addTarget(self, action: #selector(loadingViewTapped), for: .touchUpInside)
        return loadingView
    }()
    
    @objc private func loadingViewTapped() {
        loadingView.hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadingView.show(in: self.view)
        }
    }
}

