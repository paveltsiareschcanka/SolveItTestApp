//
//  UIViewController.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
