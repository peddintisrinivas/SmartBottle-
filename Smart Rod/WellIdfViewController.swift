//
//  WellIdfViewController.swift
//  Smart Rod
//
//  Created by Saraschandra on 04/07/17.
//  Copyright © 2017 MobiwareInc. All rights reserved.
//

import UIKit

class WellIdfViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{

    @IBOutlet var navigationView: UIView!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var navigationLabel: UILabel!
    
    @IBOutlet var textFieldBGView: UIView!
    
    @IBOutlet var selectWellTxtFld: UITextField!
    
    @IBOutlet var continueButton: UIButton!
    
    
    @IBOutlet var wellListTableView: UITableView!
    
    @IBOutlet var wellListTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var textFieldsBGViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var continueBtnTopCostriant: NSLayoutConstraint!
    
    var actualTextFieldsBGViewHeight : CGFloat!
    var actualcontinueBtnTopCostriant : CGFloat!
    
    let cellReuseIdentifier = "cell"
    
    let wellInfoArray : [String] = ["Landowner / Leasor","Name of Producer","Well Name","GPS Coordinates","Field Name","Railroad Commission Number","AFE Associated Number"];
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        actualTextFieldsBGViewHeight = textFieldsBGViewHeightConstraint.constant
        actualcontinueBtnTopCostriant = continueBtnTopCostriant.constant

        selectWellTxtFld.layer.cornerRadius = Constants.cornerRadiusValue
        selectWellTxtFld.attributedPlaceholder = Constants.textFieldPalceHolderColor(placeHolderText: PlaceHolderText.kWellPlaceHolder)
        selectWellTxtFld.setRightIcon(UIImage(named: "drop_down")!, imageWidth:19 , imageHegith: 11)
        selectWellTxtFld.inputView = wellListTableView;

        continueButton.layer.cornerRadius = Constants.cornerRadiusValue
        
        wellListTableView.layer.cornerRadius = 10.0
        
        wellListTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        wellListTableView .reloadData()

        

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.view .endEditing(true)
        
        UIView.animate(withDuration: Double(0.5), animations: {
            
            self.textFieldsBGViewHeightConstraint.constant = (self.actualTextFieldsBGViewHeight + 150) - 34
            self.wellListTableViewHeightConstraint.constant = 150
            self.continueBtnTopCostriant.constant = (self.actualcontinueBtnTopCostriant + 150) - 34
            self.view.layoutIfNeeded()
        })
        
    }


    @IBAction func backBtnAction(_ sender: Any)
    {
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return wellInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.wellListTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont(name: "ROBOTO-Light", size:12);
        
        cell.textLabel?.text = wellInfoArray[indexPath.row];
    
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedValue  = wellInfoArray[indexPath.row]
        selectWellTxtFld.text = selectedValue
        
        UIView.animate(withDuration: Double(0.5), animations: {
            self.textFieldsBGViewHeightConstraint.constant = self.actualTextFieldsBGViewHeight
            self.wellListTableViewHeightConstraint.constant = 0
            self.continueBtnTopCostriant.constant = self.actualcontinueBtnTopCostriant
            self.view.layoutIfNeeded()

        })
        
    }
    
    @IBAction func continueBtnAction(_ sender: Any)
    {
        let wellInfoController : UIViewController = WellInfoViewController(nibName:NibNamed.WellInfoViewController.rawValue, bundle:nil)
        self.navigationController!.pushViewController(wellInfoController, animated: true)
        
    }


    
}
