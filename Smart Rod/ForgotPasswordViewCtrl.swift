//
//  ForgotPasswordViewCtrl.swift
//  FoundmiPlus
//
//  Created by Srinivas Peddinti on 2/13/17.
//  Copyright © 2017 Christopher Larsen. All rights reserved.
//

import UIKit

class ForgotPasswordViewCtrl: UIViewController {
    
    @IBOutlet weak var submit_Btn : UIButton!
    @IBOutlet weak var emailError_Lble : UILabel!
    @IBOutlet weak var email_TF : UITextField!
    @IBOutlet weak var enterText_Lble : UILabel!
    @IBOutlet weak var textfieldControlsBackView: UIView!

    var doneToolbar = UIToolbar()
    var appDelegate : AppDelegate!
    var fadeOutTimer : Timer? = nil

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        submit_Btn.layer.masksToBounds = true
        submit_Btn.layer.cornerRadius = Constants.cornerRadiusValue
        
        email_TF.attributedPlaceholder = Constants.textFieldPalceHolderColor(placeHolderText: PlaceHolderText.kEmail)
        email_TF.layer.cornerRadius = Constants.cornerRadiusValue
        email_TF.addTarget(self, action: #selector(ForgotPasswordViewCtrl.textFieldDidChange), for: .editingChanged)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.tapGestureRecognized))
        doneToolbar = Constants.getDoneToolbar(dismissBtn: doneButton)
        email_TF.inputAccessoryView = doneToolbar
        
        emailError_Lble.alpha = 0
        
        
        let tapRecogniser : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewCtrl.tapGestureRecognized))
        self.view.addGestureRecognizer(tapRecogniser)
        
        email_TF.autocorrectionType = .no
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        email_TF.setLeftIcon(UIImage(named: "email")!, imageWidth:16, imageHegith: 13)

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
    
    
    func tapGestureRecognized()
    {
        self.textfieldControlsBackView.layoutIfNeeded()
        self.email_TF.resignFirstResponder()
        self.unhideErrorLables(unhide: false , emailOrPasswordError: "")
    }
    
    //#MARK:-- KEYBOARD NOTIFICATIONS
    
    /*!
     * @brief This method is for registering keyboard notifications
     */
    
    func registerForKeyboardNotifications()
    {
        // register for keyboard WillShow notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewCtrl.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // register for keyboard WillHide notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewCtrl.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        UIView.animate(withDuration: 1.0, animations: {
            
        })
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        UIView.animate(withDuration: 1.0, animations: {
       
        })
    }
    
    

    func textFieldDidChange()
    {
        let attributedString = NSMutableAttributedString(string: email_TF.text!)
        attributedString.addAttribute(NSKernAttributeName, value:  Constants.characterSpacing_TwoPoint, range: NSRange(location: 0, length: (email_TF.text?.characters.count)!))
        
        email_TF.attributedText = attributedString
    }
    
    //MARK: IBActions
    @IBAction func backBtnAction(_ sender: UIButton)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
      
    @IBAction func submitBtnAction(_ sender: UIButton)
    {
        self.email_TF.resignFirstResponder()

        if email_TF.text!.isEmpty
        {
            // VALIDATION TO CHECK EMAIL IS NOT NIL
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.emailEmptyError )
        }
        else if !ValidationHelper.isValidEmail(emailStr: email_TF.text!)
        {
            // VALIDATION TO CHECK EMAIL IS NOT VALIDLY ENTER BY USER
            self.unhideErrorLables(unhide: true , emailOrPasswordError:Constants.emailNotValidError )
        }
        else
        {
            //To Check internet Connectivity
            
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
                self.emailError_Lble.alpha = 0
                
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

    
    // MARK: - hide Unhide Error Lables
    func unhideErrorLables(unhide : Bool , emailOrPasswordError : String)
    {
        if unhide == true
        {
            if emailOrPasswordError == Constants.emailEmptyError
            {
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.emailError_Lble.text = "enter your email"
                    self.emailError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                
                return
            }
            else if emailOrPasswordError == Constants.emailNotValidError
            {
                UIView.animate(withDuration: 0.5, animations:
                {
                    self.emailError_Lble.text = "enter a valid email"
                    self.emailError_Lble.alpha = 1
                    self.startFadeOutTimer()
                })
                
                return
            }
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations:
            {
                self.emailError_Lble.alpha = 0
            })
        }
    }
    
    // MARK: - UITextField Delegate Methods
    
    /*!
     * @brief This method is called when UITextField resinging text field
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        email_TF.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.unhideErrorLables(unhide: false , emailOrPasswordError: "")
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
