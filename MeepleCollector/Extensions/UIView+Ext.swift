//
//  UIView+Ext.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

enum Side {
    case top(constant: CGFloat = 0)
    case bottom(constant: CGFloat = 0)
    case trailing(constant: CGFloat = 0)
    case leading(constant: CGFloat = 0)
    case all(constant: CGFloat = 0)
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func pinToSides(of view: UIView, sides: Side...) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        for side in sides {
            switch side {
            case .top(let constant):
                constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: constant))
            case .bottom(let constant):
                constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant))
            case .trailing(let constant):
                constraints.append(trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant))
            case .leading(let constant):
                constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant))
            case .all(let constant):
                pinToParent(view: view, constant: constant)
                return
            }
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    private func pinToParent(view: UIView, constant: CGFloat) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        ])
    }
}
