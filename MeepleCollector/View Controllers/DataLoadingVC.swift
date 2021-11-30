//
//  DataLoadingVC.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-29.
//

import UIKit

class DataLoadingVC: UIViewController {

    var container: UIView!
    
    func showLoadingView() {
        container = UIView(frame: view.bounds)
        view.addSubview(container)
        
        container.backgroundColor = .systemBackground
        container.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.container.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        container.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        guard let container = container else { return }
        container.removeFromSuperview()
    }

}
