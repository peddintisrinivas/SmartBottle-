//
//  SignUpViewController.swift
//  FoundmiPlus
//
//  Created by Srinivas Peddinti on 2/13/17.
//  Copyright © 2017 Christopher Larsen. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var submitBtn : UIButton!
    @IBOutlet weak var email_TF : UITextField!
    @IBOutlet weak var password_TF : UITextField!
    @IBOutlet weak var confirmPassword_TF : UITextField!
    @IBOutlet weak var emailError_Lble : UILabel!
    @IBOutlet weak var passwordError_Lble : UILabel!
    @IBOutlet weak var confirm_PasswordError_Lble : UILabel!
    @IBOutlet weak var confirmPasswordTF_Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var submitBtn_Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldBackView_Height_Constraint: NSLayoutConstraint!
    @IBOutlet weak var textfieldControlsBackView_Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTF_Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var textfieldControlsBackView: UIView!

    var doneToolbar = UIToolbar()
    var userTappedTextfield : UITextField!
    var appDelegate : AppDelegate!
    var passwordTextStr : String = ""
    var confirmPasswordTextStr : String = ""
    var fadeOutTimer : Timer? = nil
    var screenSize: CGRect = UIScreen.main.bounds

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Done toolbar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.tapGestureRecognized))
        doneToolbar = Constants.getDoneToolbar(dismissBtn: doneButton)
        
        self.email_TF.inputAccessoryView = doneToolbar
        self.password_TF.inputAccessoryView = doneToolbar
        self.confirmPassword_TF.inputAccessoryView = doneToolbar
        
        // Textield Delegates
        confirmPassword_TF.delegate = self
        password_TF.delegate = self
        
        submitBtn.layer.masksToBounds = true
        submitBtn.layer.cornerRadius = Constants.cornerRadiusValue
        
        email_TF.layer.cornerRadius = Constants.cornerRadiusValue
        password_TF.layer.cornerRadius = Constants.cornerRadiusValue
        confirmPassword_TF.layer.cornerRadius = Constants.cornerRadiusValue
        
        email_TF.autocorrectionType = .no
        password_TF.autocorrectionType = .no
        confirmPassword_TF.autocorrectionType = .no
        
        email_TF.attributedPlaceholder = Constants.textFieldPalceHolderColor(placeHolderText: PlaceHolderText.kEmail)

        password_TF.attributedPlaceholder = Constants.textFieldPalceHolderColor(placeHolderText: PlaceHolderText.kPassword)

        confirmPassword_TF.attributedPlaceholder = Constants.textFieldPalceHolderColor(placeHolderText: PlaceHolderText.kConfirmPassword)

        email_TF.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: .editingChanged)
        
        password_TF.addTarget(self, action: #selector(SignUpViewController.passwordTextFieldDidChange), for: .editingChanged)
        
        confirmPassword_TF.addTarget(self, action: #selector(SignUpViewController.passwordTextFieldDidChange), for: .editingChanged)
        

        emailError_Lble.alpha = 0
        passwordError_Lble.alpha = 0
        confirm_PasswordError_Lble.alpha = 0
        
        let tapRecogniser : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.tapGestureRecognized))
        self.view.addGestureRecognizer(tapRecogniser)
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        email_TF.setLeftIcon(UIImage(named: "email")!, imageWidth:16, imageHegith: 13)
        password_TF.setLeftIcon(UIImage(named: "lock")!, imageWidth:16, imageHegith: 19)
        confirmPassword_TF.setLeftIcon(UIImage(named: "lock")!, imageWidth:16, imageHegith: 19)
        

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
    
      internal func tapGestureRecognized()
   {
        self.email_TF.resignFirstResponder()
        self.password_TF.resignFirstResponder()
        self.confirmPassword_TF.resignFirstResponder()
        self.unhideErrorLables(unhide: false , emailOrPasswordError: "")
    }
    
    //#MARK: TextFieldDidChange
    func textFieldDidChange()
    {
        email_TF.attributedText = Constants.textCharacterSpacing(textField: email_TF)
    }
    
    func passwordTextFieldDidChange()
    {
        self.updateAsteriskPassword()
    }
    
    func updateAsteriskPassword()
    {
        if(self.userTappedTextfield.placeholder == PlaceHolderText.kPassword)
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
        else
        {
            var maskStr = ""
            
            for eachChar in (self.confirmPassword_TF.text?.characters)!
            {
                confirmPasswordTextStr += String(eachChar)
                confirmPasswordTextStr = confirmPasswordTextStr.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range:nil)

                maskStr += "*"
            }
            
            self.confirmPassword_TF.text = maskStr
        }
        
    }
    
    //#MARK: BackButton Action
    @IBAction func backBtnAction(_ sender: UIButton)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //#MARK: BackButton Action
    @IBAction func alreadyMemberAction(_ sender: UIButton)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }

    /*!
     * @brief This method is called when Submit button is selected
     */
    
    @IBAction func submitBtnAction(_ sender: UIButton)
    {
        self.email_TF.resignFirstResponder()
        self.password_TF.resignFirstResponder()
        self.confirmPassword_TF.resignFirstResponder()

        if invalidEmailPassword()
        {
            return
        }
        
       
    }
    
    private func invalidEmailPassword() -> Bool
    {
        guard let emailText = email_TF.text, let pwText = password_TF.text, let confirmPwText = confirmPassword_TF.text else
        {
            return true
        }
        
        // VALIDATION TO CHECK EMAIL AND PASSWORD IS NOT NIL
        if emailText.isEmpty && pwText.isEmpty && confirmPwText.isEmpty
        {
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.bothEmailPasswordEmptyError )
            return true
        }
        
        if emailText.isEmpty
        {
            // VALIDATION TO CHECK EMAIL IS NOT NIL
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.emailEmptyError )
            return true
        }
        
        if !ValidationHelper.isValidEmail(emailStr: emailText)
        {
            // VALIDATION TO CHECK EMAIL IS NOT VALIDLY ENTER BY USER
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.emailNotValidError )
            return true
        }
        
        if !ValidationHelper.isValidPassword(passwordStr: passwordTextStr)
        {
            self.unhideErrorLables(unhide: true, emailOrPasswordError: Constants.passwordValidError)
            return true
        }
        
        if pwText.isEmpty
        {
            ///VALIDATION TO CHECK PASSWORD IS NOT NIL
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.passwordEmptyError)
            return true
        }
        
        if confirmPwText.isEmpty
        {
            ///VALIDATION TO CHECK PASSWORD IS NOT NIL
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.confirmPasswordEmptyError)
            return true
        }
        
        if pwText.characters.count < 6
        {
            ///VALIDATION TO CHECK PASSWORD IS LESS THEN 6 CHARACTERS
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.passwordValidError)
            return true
        }
        
        if passwordTextStr != confirmPasswordTextStr
        {
            ///VALIDATION TO CHECK PASSWORD AND CONFIRM PASSWORD NOT EQUAL
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.confirmPasswordValidtionError)
            return true
        }
        
        return false
    }
    
    /*!
     * @brief This method is Display if no network Available
     */
    private func displayNoNetworkErrorMessage()
    {
        
        UIView.animate(withDuration: 0.5, animations:
        {
            self.passwordTF_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
            self.textfieldControlsBackView.layoutIfNeeded()
            self.emailError_Lble.text = Constants.networkErrorMessage
            self.emailError_Lble.alpha = 1
            self.startFadeOutTimer()
        })
    }

    // MARK: - hide Unhide Error Lables
    private func unhideErrorLables(unhide : Bool , emailOrPasswordError : String)
    {
        if unhide == true
        {
            if emailOrPasswordError == Constants.emailEmptyError
            {
                UIView.animate(withDuration: 0.5, animations:
                {
                    self.passwordTF_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()
                    self.emailError_Lble.text = "enter your info"
                    self.emailError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                
                return
            }
            else if (emailOrPasswordError == Constants.passwordEmptyError)
            {
                UIView.animate(withDuration: 0.5, animations:
                {
                    self.confirmPasswordTF_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.submitBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textFieldBackView_Height_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()
                    self.passwordError_Lble.text = "enter your password"
                    self.passwordError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                
                return
            }
            else if(emailOrPasswordError == Constants.emailNotValidError)
            {
                UIView.animate(withDuration: 0.5, animations:
                {
                    self.passwordTF_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.emailError_Lble.text = "enter a valid email"
                    self.emailError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                
                return
            }
            else if(emailOrPasswordError == Constants.passwordValidError)
            {
                UIView.animate(withDuration: 0.5, animations:
                {
                    self.confirmPasswordTF_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.submitBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                      self.textFieldBackView_Height_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()
                    self.passwordError_Lble.text = "enter 6 character password without spaces"
                    self.passwordError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                
                return
            }
            else if(emailOrPasswordError == Constants.confirmPasswordEmptyError)
            {
                UIView.animate(withDuration: 0.5, animations:
                  {
                    self.confirm_PasswordError_Lble.text = "enter confirm password"
                    self.confirm_PasswordError_Lble.alpha = 1
                    self.startFadeOutTimer()
                  })
                
                return
            }
            else if(emailOrPasswordError == Constants.confirmPasswordValidtionError)
            {
                UIView.animate(withDuration: 0.5, animations:
                {
                    self.confirm_PasswordError_Lble.text = "password and confirm password do not match"
                    self.confirm_PasswordError_Lble.alpha = 1
                    self.startFadeOutTimer()
                    self.passwordTextStr = ""
                    self.password_TF.text = ""
                    self.confirmPasswordTextStr = ""
                    self.confirmPassword_TF.text = ""

                })
                
                return
            }
            else
            {
                UIView.animate(withDuration: 0.5, animations:
                {
                    self.passwordTF_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.confirmPasswordTF_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.submitBtn_Top_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                      self.textFieldBackView_Height_Constraint.constant = Constants.error_Unhide_TopConstraintValue
                    self.textfieldControlsBackView.layoutIfNeeded()
                    self.emailError_Lble.alpha = 1
                    self.passwordError_Lble.alpha = 1
                    self.confirm_PasswordError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
            }
            
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations:
            {
                self.confirmPasswordTF_Top_Constraint.constant = Constants.error_Hide_TopConstraintValue
                self.passwordTF_Top_Constraint.constant = Constants.error_Hide_TopConstraintValue
                self.submitBtn_Top_Constraint.constant = Constants.error_Hide_TopConstraintValue
                  self.textFieldBackView_Height_Constraint.constant = Constants.error_Hide_TopConstraintValue
                self.textfieldControlsBackView.layoutIfNeeded()
                self.emailError_Lble.alpha = 0
                self.passwordError_Lble.alpha = 0
                self.confirm_PasswordError_Lble.alpha = 0
            })
        }
    }
    
    /*!
     * @brief This method is used for fade in and fade out the error label
     */
    
    // MARK: - Timer Methods
    
    internal func fadeOutTimerEnded()
    {
        self.tapGestureRecognized()
    }
    
    internal func startFadeOutTimer()
    {
        self.invalidateFadeOutTimer()
        
        self.fadeOutTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(fadeOutTimerEnded), userInfo: nil, repeats: false)
    }
    
    internal func invalidateFadeOutTimer()
    {
        if self.fadeOutTimer != nil
        {
            self.fadeOutTimer?.invalidate()
            
        }
    }

    //#MARK:-- KEYBOARD NOTIFICATIONS
    
    /*!
     * @brief This method is for registering keyboard notifications
     */
    
    func registerForKeyboardNotifications()
    {
        // register for keyboard WillShow notifications
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // register for keyboard WillHide notifications
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    internal func keyboardWillShow(notification: NSNotification)
    {
        if screenSize.size.height <= 568{
            UIView.animate(withDuration: 1.0, animations: {
                self.textfieldControlsBackView_Top_Constraint.constant = Constants.signup_Top_ConstraintValue
                self.textfieldControlsBackView.layoutIfNeeded()
            })
        }
    }
    
    internal func keyboardWillHide(notification: NSNotification)
    {
        if screenSize.size.height <= 568
        {
            UIView.animate(withDuration: 1.0, animations: {
                self.textfieldControlsBackView_Top_Constraint.constant = 110
                self.textfieldControlsBackView.layoutIfNeeded()
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
            password_TF.becomeFirstResponder()
        }
        else if textField == password_TF
        {
            password_TF.resignFirstResponder()
            confirmPassword_TF.becomeFirstResponder()
        }
        else
        {
            confirmPassword_TF.resignFirstResponder()
        }
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.userTappedTextfield = textField
        self.unhideErrorLables(unhide: false , emailOrPasswordError: "")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        if textField == password_TF
        {
            passwordTextStr = password_TF.text!
        }
        else if textField == confirmPassword_TF
        {
            confirmPasswordTextStr = confirmPassword_TF.text!
        }
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92)
        {
            if(textField == password_TF)
            {
                passwordTextStr = String(passwordTextStr.characters.dropLast())
            }
            else if textField == confirmPassword_TF
            {
                confirmPasswordTextStr = String(confirmPasswordTextStr.characters.dropLast())
            }
            
            print("passwordTextStr = \(passwordTextStr)")
            print("confirmPasswordTextStr = \(confirmPasswordTextStr)")
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
