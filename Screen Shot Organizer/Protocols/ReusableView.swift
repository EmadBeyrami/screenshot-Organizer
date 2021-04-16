//
//  ReusableView.swift
//  Screen Shot Organizer
//
//  Created by Emad Beyrami on 1/26/1400 AP.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
