//
//  UIStoryboard+Instantiation.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/25/1400 AP.
//

import UIKit

extension UIStoryboard {
    /// Available StoryBoards
    class var main: UIStoryboard {
        return self.init(name: "Main", bundle: nil)
    }
    
    /// Easier Way to Instansiate ViewControllers
    func instantiate<T: UIViewController>(viewController: T.Type) -> T {
        return self.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
}
