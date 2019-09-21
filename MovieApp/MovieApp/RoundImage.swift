//
//  RoundImage.swift
//  MovieApp
//
//  Created by Bartu akman on 11.07.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.

import UIKit

class RoundImage: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var bgColor: UIColor? {
        didSet{
            backgroundColor = bgColor
        }
    }
}
