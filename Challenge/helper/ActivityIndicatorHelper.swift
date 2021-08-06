//
//  ActivityIndicatorHelper.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import Foundation
import UIKit

class ActivityIndicatorHelper {
    
    var loadingView: UIView
    var activityIndicator: UIActivityIndicatorView
    
    init(view: UIView) {
        self.loadingView = UIView()
        self.loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.loadingView.center = view.center
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
        self.loadingView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = UIColor.white
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        self.loadingView.addSubview(activityIndicator)
        self.loadingView.isHidden = true
        view.addSubview(loadingView)
    }
    
    func start() {
        self.loadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
        self.loadingView.isHidden = true
    }
}
