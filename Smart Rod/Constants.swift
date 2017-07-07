//
//  Constants.swift
//  Foundmi
//
//  Created by Srinivas Peddinti on 2/8/17.
//  Copyright © 2017 MobiwareInc. All rights reserved.
//

import UIKit

struct ProfileNotifications
{
    static let UserProfileInfoUpdated = Notification.Name(rawValue: "UserProfileUpdated")
}

struct PlaceHolderText
{
    static let kEmail = "Email"
    static let kFirstName = "First name"
    static let kLastName = "Last name"
    static let kUpdatePassword = "Update Password"
    static let kConfirmPassword = "Confirm Password"
    static let kPassword = "Password"
    static let kWellPlaceHolder = "Select your well identification"
}

class Constants: NSObject
{
    static let placedHolderTextFieldColor : UIColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
    static let animationDuration: TimeInterval = 0.15
    static let lightTextColor : UIColor = UIColor.lightText
    static let cornerRadiusValue : CGFloat = 20.0
    static let buttonBorder: CGFloat = 1.0
    static let buttonCornerRadius: CGFloat = 10.0
    static let helpButnCornerWidth : CGFloat = 2.0
    static let characterSpacing_TwoPoint : CGFloat = 2.0
    static let characterSpacing_TwoPointFive : CGFloat = 2.5
    static let characterSpacing_OnePointSix : CGFloat = 1.6
    static let characterSpacing_OnePointSeven : CGFloat = 1.7
    static let characterSpacing_OnePointTwo : CGFloat = 1.2
    static let error_Unhide_TopConstraintValue : CGFloat = 40.0
    static let error_Hide_TopConstraintValue : CGFloat = 20.0
    static let textFields_Bottom_ConstraintValue : CGFloat = 60.0
    static let logoImageView_TopValue_Tapped : CGFloat = 84.0
    static let logoImageView_TopValue_UnTapped : CGFloat = 124.0
    
    // MARK: Errors
    static let emailEmptyError : String = "EmailEmptyError"
    static let passwordEmptyError : String = "PasswordEmptyError"
    static let confirmPasswordEmptyError : String = "ConfirmPasswordEmptyError"
    static let passwordValidError : String = "passwordValidError"
    static let bothEmailPasswordEmptyError : String = "EmailPasswordEmptyError"
    static let emailNotValidError : String = "EmailNotValidError"
    static let confirmPasswordValidtionError : String = "confirmPasswordValidtionError"

    static let kUserSuccessfullySignedIn = "userSignInSuccessfull"
    static let kIsUserLoggedInFirstTime = "isUserLoginFirstTime"
    static let kLoginUserName = "Loginusername"
    static let kIsLoginFromSocialNtrwk = "loginFromSocialNtrwk"
    
    // MARK: Fonts
    static let avenir_heavy = "Avenir-Heavy"
    static let avenir_medium = "Avenir-Medium"
    static let avenir_light = "Avenir-Light"

    static func getDoneToolbar(dismissBtn: UIBarButtonItem) -> UIToolbar
    {
        let doneToolbar = UIToolbar()
        
        doneToolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = dismissBtn
        doneToolbar.setItems([spaceButton, doneButton], animated: false)
        doneToolbar.isUserInteractionEnabled = true
        
        return doneToolbar
    }
    
    // MARK: Alert Messages
    static let signUpSuccessMessage = "User has been registered successfully"
    static let emailAlreadyTaken = "is already taken."
    static let uicontrols_Top_ConstraintValue : CGFloat = -50.0
    static let signup_Top_ConstraintValue : CGFloat = 50.0

    static let networkErrorMessage : String = "please check internet connection"
    static func isNetworkReachable() -> Bool
    {
        ///NEED TO REMOVE ONCE SERVICES INTERGRATED
        return true
    }

       static let backGrndwhiteColor = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor,
                                     UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor]

    static func textFieldPalceHolderColor(placeHolderText : String) ->NSAttributedString
    {
       return NSAttributedString(string:placeHolderText, attributes: [NSForegroundColorAttributeName: Constants.placedHolderTextFieldColor])
    }
    
    static func textCharacterSpacing(textField : UITextField) ->NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSKernAttributeName, value:  Constants.characterSpacing_TwoPoint, range: NSRange(location: 0, length: (textField.text?.characters.count)!))
        return attributedString
    }

}
