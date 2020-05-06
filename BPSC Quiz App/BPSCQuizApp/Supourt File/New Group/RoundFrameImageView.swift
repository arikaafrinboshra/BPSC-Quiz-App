//
//  RoundFrameImageView.swift
//  QuizDesignOne
//
//  Created by Arika Afrin Boshra on 27/2/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

@IBDesignable
class RoundFrameImageView: UIImageView {

    @IBInspectable var roundImageView: Bool = false {
        
        didSet{
            
            if roundImageView{
                
                layer.cornerRadius = frame.height / 2
                
            }
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        
        if roundImageView{
            
            layer.cornerRadius = frame.height / 2
            
        }
    }


}
