//
//  UICollectionView+Register.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/24/1400 AP.
//

import UIKit

extension UICollectionView {
    
    /// Register cells with nib file
    func registerNib<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell), bundle: nil),
                      forCellWithReuseIdentifier: String(describing: cell))
    }
    
    ///Register Cell
    func register<T: UICollectionViewCell & ReusableView>(_ cell: T.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    ///Register ReusableViews
    func registerReusableView<T: UICollectionReusableView & ReusableView>(_ cell: T.Type, ofKind: String) {
        self.register(cell,
                      forSupplementaryViewOfKind: ofKind,
                      withReuseIdentifier: String(describing: cell))
    }
    
}
