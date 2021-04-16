//
//  UIView+AutoLayout.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/25/1400 AP.
//

import UIKit

extension UIView {
    /// Auto Layout Helper
    func fillSuperView(padding: CGFloat = 0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding).isActive = true
    }
}


