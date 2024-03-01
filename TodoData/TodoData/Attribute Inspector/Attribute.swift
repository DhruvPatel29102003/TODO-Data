//
//  Attribute.swift
//  TodoData
//
//  Created by Droadmin on 12/12/23.
//

import Foundation
import UIKit

@IBDesignable extension UITextView {
    @IBInspectable var borderWidth: CGFloat{
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor
    {
        get
        {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set
        {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
}
