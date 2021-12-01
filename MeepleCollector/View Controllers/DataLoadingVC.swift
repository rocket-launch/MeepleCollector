//
//  DataLoadingVC.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-29.
//

import UIKit

class DataLoadingVC: UIViewController {

    var loadingContainer: UIView!
    var addedContainer: UIView!
    var addedLabel = MCBodyLabel(frame: .zero)
    var addedIcon = UIImageView()
    
    func showLoadingView() {
        loadingContainer = UIView(frame: view.bounds)
        view.addSubview(loadingContainer)
        
        loadingContainer.backgroundColor = .systemBackground
        loadingContainer.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.loadingContainer.alpha = 1
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        loadingContainer.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        guard let _ = loadingContainer else { return }
        loadingContainer.removeFromSuperview()
    }

    
    func showAddedConfirmation() {
        addedContainer = UIView(frame: .zero)
        view.addSubview(addedContainer)
        addedContainer.translatesAutoresizingMaskIntoConstraints = false
        addedContainer.layer.cornerRadius = 10
        
        addedContainer.backgroundColor = UIColor.clear
        addedContainer.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.addedContainer.backgroundColor = .systemPink
            self.addedContainer.alpha = 0.9
        }
        
        addedContainer.addSubviews(addedLabel, addedIcon)
        addedLabel.translatesAutoresizingMaskIntoConstraints = false
        addedLabel.text = "Added to your collection!"
        addedLabel.textAlignment = .center
        addedLabel.textColor = .white
        
        addedIcon.translatesAutoresizingMaskIntoConstraints = false
        addedIcon.image = UIImage(systemName: "checkmark.circle")
        addedIcon.tintColor = .white
        
        NSLayoutConstraint.activate([
            addedContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addedContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addedContainer.heightAnchor.constraint(equalToConstant: 220),
            addedContainer.widthAnchor.constraint(equalTo: addedContainer.heightAnchor),
            
            addedIcon.centerXAnchor.constraint(equalTo: addedContainer.centerXAnchor),
            addedIcon.centerYAnchor.constraint(equalTo: addedContainer.centerYAnchor, constant: -15),
            addedIcon.heightAnchor.constraint(equalToConstant: 100),
            addedIcon.widthAnchor.constraint(equalTo: addedIcon.heightAnchor),
            
            addedLabel.topAnchor.constraint(equalTo: addedIcon.bottomAnchor, constant: 5),
            addedLabel.leadingAnchor.constraint(equalTo: addedContainer.leadingAnchor),
            addedLabel.trailingAnchor.constraint(equalTo: addedContainer.trailingAnchor),
            addedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func dismissAddedConfirmation(completion: @escaping () -> Void) {
        guard let _ = addedContainer else { return }
        UIView.animate(withDuration: 0.5) {
            self.addedContainer.alpha = 0
        } completion: { _ in
            self.addedContainer.removeFromSuperview()
            self.addedContainer = nil
            completion()
        }
    }
}
