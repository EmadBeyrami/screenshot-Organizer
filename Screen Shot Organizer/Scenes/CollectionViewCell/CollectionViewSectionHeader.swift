//
//  SectionHeader.swift
//  Screen Shot Organizer
//
//  Created by Emad Beyrami on 1/26/1400 AP.
//

import UIKit

class CollectionViewSectionHeader: UICollectionReusableView {
    
    //MARK: - properties
    fileprivate lazy var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    ///Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.fillSuperView()
        
        self.backgroundColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// setter
    func setTitle(_ title: String) {
        self.label.text = title
    }

}

extension CollectionViewSectionHeader: ReusableView { }
