//
//  UnderLine.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 4/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class UnderLine: UITextField {

    @IBInspectable
    var UnderLineOn: Bool = false{
        didSet{
            self.setUnderLine()
        }
    
    }

}

extension UITextField {
    func setUnderLine() {
        
          self.borderStyle = .none
          self.layer.backgroundColor = UIColor.white.cgColor

          self.layer.masksToBounds = false
          self.layer.shadowColor = UIColor.black.cgColor
          self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
          self.layer.shadowOpacity = 1.0
          self.layer.shadowRadius = 0.0
        
    }
}
