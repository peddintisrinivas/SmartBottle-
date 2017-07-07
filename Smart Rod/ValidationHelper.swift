//
//  ValidationHelper.swift
//  Foundmi
//
//  Created by Srinivas Peddinti on 2/10/17.
//  Copyright © 2017 MobiwareInc. All rights reserved.
//

import UIKit

class ValidationHelper: NSObject
{
    class func isValidEmail(emailStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    class func isValidPassword(passwordStr: String) -> Bool
    {
        print("password str: \(passwordStr)")
        
        let spaces = NSCharacterSet.whitespaces
        
        if passwordStr.rangeOfCharacter(from: spaces) != nil
        {
            print("password Str failed: \(passwordStr)")
            return false
        }

        return true
    }
}
