//
//  UICollectionView+DequeueCell.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/24/1400 AP.
//

import UIKit

extension UICollectionView {
    /// better use of cell dequeue
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as! T
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(_ cell: T.Type, ofKind kind: String, indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: cell), for: indexPath) as! T
    }
    
}
