//
//  UITextField+TextStyling.swift
//  FoundmiPlus
//
//  Created by Christopher Larsen on 2/15/17.
//  Copyright © 2017 Christopher Larsen. All rights reserved.
//

import Foundation

/*!
 * @brief This method is called when there is Character Spacing needed for UITextField PlaceHolder
 */
#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#endif

extension UITextField
{
    func setLeftIcon(_ icon: UIImage, imageWidth : Int, imageHegith : Int) {
        
        let padding = 12
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth+padding*3, height: imageHegith) )
        let iconView  = UIImageView(frame: CGRect(x: padding+10, y: 0, width: imageWidth, height: imageHegith))
        iconView.image = icon
        outerView.backgroundColor = UIColor.clear
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always  
    }
   
    func setRightIcon(_ icon: UIImage, imageWidth : Int, imageHegith : Int)
    {
        
        let padding = 12
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth+padding*2, height: imageHegith) )
        let iconImageView  = UIImageView(frame: CGRect(x: padding, y: 0, width: imageWidth, height: imageHegith))
        iconImageView.image = icon
        outerView.addSubview(iconImageView)
        
        rightView = outerView
        rightViewMode = .always
    }
}

