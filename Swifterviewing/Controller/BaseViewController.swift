//
//  BaseViewController.swift
//  Swifterviewing
//
//  Created by SOWJI on 01/08/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var currentOverlay: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showOverlay() {
        self.hideOverLay()
        // Create the overlay
        let overlay = UIView(frame: self.view.frame)
        overlay.center = self.view.center
        overlay.alpha = 0.3
        overlay.backgroundColor = UIColor.black
        self.view.addSubview(overlay)
        self.view.bringSubviewToFront(overlay)
        
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.color = .blue
        loadingIndicator.center = overlay.center
        loadingIndicator.startAnimating()
        self.currentOverlay = overlay
        self.currentOverlay?.addSubview(loadingIndicator)
    }
    func hideOverLay() {
        if self.currentOverlay != nil {
            self.currentOverlay?.removeFromSuperview()
            self.currentOverlay =  nil
        }
    }
    
}
