//
//  LoginViewController.swift
//  FoundmiPlus
//
//  Created by Srinivas Peddinti on 2/13/17.
//  Copyright © 2017 Christopher Larsen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var signIn_Btn : UIButton!
    @IBOutlet weak var email_TF : UITextField!
    @IBOutlet weak var password_TF : UITextField!
    @IBOutlet weak var emailError_Lble : UILabel!
    @IBOutlet weak var passwordError_Lble : UILabel!
    @IBOutlet weak var passwordBtn_Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var signInBtn_Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var textfieldControlsBackView_Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var textfieldControlsBackView: UIView!
    var doneToolbar = UIToolbar()
    var fadeOutTimer : Timer? = nil
    var text : String!
    var passwordTextStr : String = ""
    var appDelegate : AppDelegate!
    var screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        password_TF.delegate = self

        signIn_Btn.layer.masksToBounds = true
        signIn_Btn.layer.cornerRadius = Constants.cornerRadiusValue
        
        email_TF.layer.cornerRadius = Constants.cornerRadiusValue
        password_TF.layer.cornerRadius = Constants.cornerRadiusValue
        
        email_TF.attributedPlaceholder = Constants.textFieldPalceHolderColor(placeHolderText: PlaceHolderText.kEmail)

        password_TF.attributedPlaceholder = Constants.textFieldPalceHolderColor(placeHolderText: PlaceHolderText.kPassword)
        
        password_TF.addTarget(self, action: #selector(LoginViewController.passwordTextFieldDidChange), for: .editingChanged)
        
        // Done toolbar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.tapGestureRecognized))
        doneToolbar = Constants.getDoneToolbar(dismissBtn: doneButton)
        
        emailError_Lble.alpha = 0
        passwordError_Lble.alpha = 0
        
        email_TF.autocorrectionType = .no
        password_TF.autocorrectionType = .no
        
        email_TF.inputAccessoryView = doneToolbar
        password_TF.inputAccessoryView = doneToolbar
        
        let tapRecogniser : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.tapGestureRecognized))
        self.view.addGestureRecognizer(tapRecogniser)
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        email_TF.setLeftIcon(UIImage(named: "email")!, imageWidth:16, imageHegith: 13)
        password_TF.setLeftIcon(UIImage(named: "lock")!, imageWidth:16, imageHegith: 19)


    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true);
        
        self.registerForKeyboardNotifications()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*!
     * @brief This method is Display if no network Available
     */
    func displayNoNetworkErrorMessage()
    {
        
        UIView.animate(withDuration: 0.5, animations:
        {
            self.passwordBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
            self.signInBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
            self.textfieldControlsBackView.layoutIfNeeded()
            self.emailError_Lble.text = Constants.networkErrorMessage
            self.emailError_Lble.alpha = 1
            self.startFadeOutTimer()
        })
        
    }

    //#MARK:-- KEYBOARD NOTIFICATIONS
    
    /*!
     * @brief This method is for registering keyboard notifications
     */
    
    func registerForKeyboardNotifications()
    {
        // register for keyboard WillShow notifications
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // register for keyboard WillHide notifications
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    internal func keyboardWillShow(notification: NSNotification)
    {
        if screenSize.size.height <= 568{
        UIView.animate(withDuration: 1.0, animations: {
            self.textfieldControlsBackView_Top_Constraint.constant = Constants.uicontrols_Top_ConstraintValue
            self.textfieldControlsBackView.layoutIfNeeded()
            })
        }
    }
    
   internal func keyboardWillHide(notification: NSNotification)
    {
        if screenSize.size.height <= 568
        {
        UIView.animate(withDuration: 1.0, animations: {
            self.textfieldControlsBackView_Top_Constraint.constant = 0
            self.textfieldControlsBackView.layoutIfNeeded()
            })
        }
    }
    
    func tapGestureRecognized()
    {
        self.textfieldControlsBackView.layoutIfNeeded()
        self.email_TF.resignFirstResponder()
        self.password_TF.resignFirstResponder()
        self.unhideErrorLables(unhide: false , emailOrPasswordError: "")
    }
    
    func textFieldDidChange()
    {
        email_TF.attributedText = Constants.textCharacterSpacing(textField: email_TF)
        
    }

    @IBAction func signInBtnAction(_ sender: UIButton)
    {
        self.email_TF.resignFirstResponder()
        self.password_TF.resignFirstResponder()

        ///VALIDATION TO CHECK EMAIL AND PASSWORD IS NOT NIL
        if email_TF.text!.isEmpty && password_TF.text!.isEmpty
        {
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.bothEmailPasswordEmptyError )
        }
        else if !ValidationHelper.isValidEmail(emailStr: email_TF.text!)
        {
            // VALIDATION TO CHECK EMAIL IS NOT VALIDLY ENTER BY USER
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.emailNotValidError )
        }
        else if email_TF.text!.isEmpty
        {
            // VALIDATION TO CHECK EMAIL IS NOT NIL
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.emailEmptyError )
        }
        else if password_TF.text!.isEmpty
        {
            // VALIDATION TO CHECK PASSWORD IS NOT NIL
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.passwordEmptyError)
        }
        else
        {
            //To Check internet Connectivity
            if(Constants.isNetworkReachable())
            {
                //success
                let wellIdfViewController = WellIdfViewController(nibName: "WellIdfViewController", bundle: nil)
                self.navigationController?.pushViewController(wellIdfViewController, animated: true);

            }
        else
        {
        ///IF NO INTERNET AVAILABLE NEED TO DISPLAY ALERT
        self.displayNoNetworkErrorMessage()
       }
        
     }
   }
    /*!
     * @brief This method is used for fade in and fade out the error label
     */

    // MARK: - Timer Methods
    
    func fadeOutTimerEnded()
    {
        UIView.animate(withDuration: 0.5, animations:
        {
            self.passwordBtn_Top_Constraint.constant = Constants.error_Hide_TopConstraintValue
            self.signInBtn_Top_Constraint.constant = Constants.error_Hide_TopConstraintValue
            self.textfieldControlsBackView.layoutIfNeeded()
            self.emailError_Lble.alpha = 0
            self.passwordError_Lble.alpha = 0

        })
        
    }
    
    func startFadeOutTimer()
    {
        self.invalidateFadeOutTimer()
        
        self.fadeOutTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(fadeOutTimerEnded), userInfo: nil, repeats: false)
    }
    
    func invalidateFadeOutTimer()
    {
        if self.fadeOutTimer != nil
        {
            self.fadeOutTimer?.invalidate()
        }
    }

    //#MARK:-- FORGOT BUTTON ACTION
    
    @IBAction func forgotBtnAction(_ sender: UIButton)
    {
        let forgotPasswordViewCtrl = ForgotPasswordViewCtrl(nibName: "ForgotPasswordViewCtrl", bundle: nil)
        self.navigationController?.pushViewController(forgotPasswordViewCtrl, animated: true);
    }
    
    //#MARK:-- CREATE BUTTON ACTION
    
    @IBAction func createBtnAction(_ sender: UIButton)
    {
        
        let signUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(signUpViewController, animated: true);

    }
    // MARK: - hide Unhide Error Lables
    
    func unhideErrorLables(unhide : Bool , emailOrPasswordError : String)
    {
        if unhide == true
        {
            if emailOrPasswordError == Constants.emailEmptyError
            {
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.passwordBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.signInBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()
                    self.emailError_Lble.text = "enter your email"
                    self.emailError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                return
            }
            else if emailOrPasswordError == Constants.passwordEmptyError
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.passwordError_Lble.text = "enter your password"
                    self.signInBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()

                    self.passwordError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                return
            }
            else if emailOrPasswordError == Constants.emailNotValidError
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.passwordBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()
                    self.emailError_Lble.text = "enter a valid email"
                    self.emailError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                return
            }
            else
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.passwordBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.signInBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()
                    self.emailError_Lble.alpha = 1
                    self.passwordError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                return
            }
        }
            
        else{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.passwordBtn_Top_Constraint.constant = Constants.error_Hide_TopConstraintValue
                self.signInBtn_Top_Constraint.constant = Constants.error_Hide_TopConstraintValue
                self.textfieldControlsBackView.layoutIfNeeded()
                self.emailError_Lble.alpha = 0
                self.passwordError_Lble.alpha = 0
            })
        }        
    }
    
    // MARK: - UITextField Delegate Methods
    
    /*!
     * @brief This method is called when UITextField resinging text field
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == email_TF
        {
            email_TF.resignFirstResponder()
        }
        else
        {
            password_TF.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.unhideErrorLables(unhide: false , emailOrPasswordError: "")
    }

    func passwordTextFieldDidChange()
    {
        self.updateAsteriskPassword()
    }

    func updateAsteriskPassword()
    {
        var maskStr = ""
        
        for eachChar in (self.password_TF.text?.characters)!
        {
            passwordTextStr += String(eachChar)
            passwordTextStr = passwordTextStr.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range:nil)

            maskStr += "*"
        }
        
        self.password_TF.text = maskStr
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString
        string: String) -> Bool
    {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92)
        {
            if(textField == password_TF)
            {
                passwordTextStr = String(passwordTextStr.characters.dropLast())
            }
        }
        
        return true
    }
    
    // MARK: - DEINIT METHOD
    
    /*!
     * @brief This method is used to remove observers
     */
    deinit
    {
        NotificationCenter.default.removeObserver(self);
    }    
}
