//
//  WellInfoViewController.swift
//  Smart Rod
//
//  Created by Saraschandra on 05/07/17.
//  Copyright © 2017 MobiwareInc. All rights reserved.
//

import UIKit

class WellInfoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    let firstCellColor : UIColor = UIColor(red: 93/255, green: 93/255, blue: 65/255, alpha: 1)
    let secondCellColor : UIColor = UIColor(red: 42/255, green: 57/255, blue: 95/255, alpha: 1)
    let thirdCellColor : UIColor = UIColor(red: 48/255, green: 92/255, blue: 84/255, alpha: 1)
    let fourthCellColor : UIColor = UIColor(red: 44/255, green: 66/255, blue: 96/255, alpha: 1)
    let fifthCellColor : UIColor = UIColor(red: 87/255, green: 118/255, blue: 107/255, alpha: 1)
    let sixthCellColor : UIColor = UIColor(red: 66/255, green: 77/255, blue: 121/255, alpha: 1)
    let seventhCellColor : UIColor = UIColor(red: 67/255, green: 67/255, blue: 88/255, alpha: 1)
    let eightCellColor : UIColor = UIColor(red: 57/255, green: 115/255, blue: 104/255, alpha: 1)
    
    let firstCellBorderColor = UIColor(red: 169/255, green: 70/255, blue: 70/255, alpha: 1).cgColor
    let secondCellBorderColor  = UIColor(red: 93/255, green: 94/255, blue: 171/255, alpha: 1).cgColor
    let thirdCellBorderColor  = UIColor(red: 23/255, green: 125/255, blue: 91/255, alpha: 1).cgColor
    let fourthCellBorderColor  = UIColor(red: 41/255, green: 112/255, blue: 155/255, alpha: 1).cgColor
    let fifthCellBorderColor  = UIColor(red: 100/255, green: 158/255, blue: 65/255, alpha: 1).cgColor
    let sixthCellBorderColor  = UIColor(red: 128/255, green: 62/255, blue: 113/255, alpha: 1).cgColor
    let seventhCellBorderColor  = UIColor(red: 110/255, green: 93/255, blue: 54/255, alpha: 1).cgColor
    let eightCellBorderColor  = UIColor(red: 56/255, green: 144/255, blue: 119/255, alpha: 1).cgColor
    
    let reuseIdentifier = "WellInfoCell"
    
    @IBOutlet var navigationView: UIView!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var wellInfoCollectionView: UICollectionView!
    
    var wellInfoArray : NSArray!
    
    //var wellInfoArray = [["color" : "device settings"],["settingTitle" : "social connections"],["settingTitle" : "profile"],["settingTitle" : "tutorial"]]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "WellInfoCollectionViewCell", bundle: nil)
        self.wellInfoCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        wellInfoCollectionView.delegate = self
        wellInfoCollectionView.dataSource = self
        
        let firstCellSubDict = ["Superintendent" : "Add Something","Engineer(s)" : "Add Something","Production Foreman" : "Add Something","Administration Assistant" : "Add Something", "Accounts Payable" : "Add Something","Safety Manager" : "Add Something","Emergency Contact" : "Add Something"]
        
        let secondCellSubDict = ["Pump Jack" : "Add Something","Casing" : "Add Something","Tubing" : "Add Something","Steel Sucker Rods" : "Add Something", "Fiberglass Sucker Rods" : "Add Something","Pumps" : "Add Something","Chemicals" : "Add Something","Tubing Anchor" : "Add Something","Pump-off Controller" : "Add Something","Wellhead" : "Add Something","Wellhead Assembly" : "Add Something","Flowline" : "Add Something","Panel Box" : "Add Something","Electric Transformers" : "Add Something"]
        
        let thirdCellSubDict = ["Roustabout Company" : "Add Something","Electrician" : "Add Something","Fluid Services(Chemicals)" : "Add Something","Fluid Services(Transport)" : "Add Something", "Hot Oiler (Transport)" : "Add Something","Workover / Pulling Unit" : "Add Something","Kill Truck / Pump Truck" : "Add Something","Hot Shot" : "Add Something","Inspection Services(Tubing)" : "Add Something","Inspection Services(Rods)" : "Add Something","Pumps" : "Add Something","Gatherer for Crude Oil & Condensate" : "Add Something","Contract Pumper" : "Add Something","Completion / Flowback Company" : "Add Something","Tank Rentals" : "Add Something","Construction for Location" : "Add Something","Well Analyst Tech" : "Add Something","Wireline" : "Add Something","Automation" : "Add Something","Communications" : "Add Something"]

        let fourthCellSubDict = ["Seatnipple Depth(SNDepth)" : "Add Something","Harmonics Number" : "Add Something","Surface Stroke" : "Add Something","Downhole Stroke" : "Add Something", "Stroke Length per Pumping Unit" : "Add Something","Stroke per Minute for Pumping Unit" : "Add Something","NA / NO" : "Add Something","FÆ / Skr" : "Add Something","Fluid Level" : "Add Something","Fluid Level Above Pump (FLAP)" : "Add Something","Feet From Surface (FFS)" : "Add Something","Tubing Pressure" : "Add Something","Casing Pressure" : "Add Something","Motor Horsepower" : "Add Something","Pumping Unit Size" : "Add Something","Tubing Size" : "Add Something","Tubing Anchor - lbs of tension" : "Add Something","Pump Size for Rod Pump" : "Add Something","Rod Count - Steel Sucker Rods" : "Add Something","Rod Count - Fiberglass Sucker Rods" : "Add Something","Sinker Bars" : "Add Something","MTR's for Tubing" : "Add Something","Rod Star Inputs" : "Add Something","Wellview" : "Add Something","Deviation Reports" : "Add Something"]
        
        let fifthCellSubDict = ["API(in degress)" : "Add Something","Gravity of Water(Milgrams per liter)" : "Add Something","Pump in-take Pressure" : "Add Something","Oil Cut (Oil)" : "Add Something", "Oil Cut (Water)" : "Add Something","Total Volume(Oil)" : "Add Something","Total Volume(Water)" : "Add Something","Gas Volume" : "Add Something","Gas Composition" : "Add Something"]
        
        
        
        let firstCellDict = ["Background Color" : firstCellColor, "Border Color" : firstCellBorderColor, "Image" : "contact", "Name" : "Contact Information","DetailInfo" : firstCellSubDict] as [String : Any]
        let secondCellDict = ["Background Color" : secondCellColor, "Border Color" : secondCellBorderColor, "Image" : "producing", "Name" : "Producing Assets","DetailInfo" : secondCellSubDict] as [String : Any]
        let thirdCellDict = ["Background Color" : thirdCellColor, "Border Color" : thirdCellBorderColor, "Image" : "service", "Name" : "Service Companies","DetailInfo" : thirdCellSubDict] as [String : Any]
        let fourthCellDict = ["Background Color" : fourthCellColor, "Border Color" : fourthCellBorderColor, "Image" : "design", "Name" : "Design Engineering","DetailInfo" : fourthCellSubDict] as [String : Any]
        let fifthCellDict = ["Background Color" : fifthCellColor, "Border Color" : fifthCellBorderColor, "Image" : "fluid", "Name" : "Fluid Make-Up","DetailInfo" : fifthCellSubDict] as [String : Any]
        let sixthCellDict = ["Background Color" : sixthCellColor, "Border Color" : sixthCellBorderColor, "Image" : "chemicals", "Name" : "Chemicals Treating","DetailInfo" : NSNull()] as [String : Any]
        let seventhCellDict = ["Background Color" : seventhCellColor, "Border Color" : seventhCellBorderColor, "Image" : "rod", "Name" : "Rod Star","DetailInfo" : NSNull()] as [String : Any]
        let eightCellDict = ["Background Color" : eightCellColor, "Border Color" : eightCellBorderColor, "Image" : "analysis", "Name" : "Failure Analysis & Resolution","DetailInfo" : NSNull()] as [String : Any]

        
        wellInfoArray = [firstCellDict, secondCellDict, thirdCellDict, fourthCellDict, fifthCellDict, sixthCellDict,seventhCellDict,eightCellDict];

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (wellInfoCollectionView.frame.size.width - 50)/2 , height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return wellInfoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WellInfoCollectionViewCell
        let wellInfoDictionary = wellInfoArray[indexPath.row] as! NSDictionary
        
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        
        cell.backgroundColor = wellInfoDictionary.object(forKey: "Background Color") as! UIColor?
        
        let borderColor = wellInfoDictionary.object(forKey: "Border Color")
        cell.layer.borderColor = borderColor as! CGColor?
        
        let imageName = wellInfoDictionary.object(forKey: "Image") as! String?
        cell.wellInfoCellImageView.image = UIImage(named:imageName!)
        cell.wellInfoLabel.text = wellInfoDictionary.object(forKey: "Name") as! String?;
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let selectedDict  = wellInfoArray[indexPath.row] as! NSDictionary
        let selectedName = selectedDict.object(forKey: "Name") as! NSString
        
        let wellDetailInfoController : WellDetailInfoViewController = WellDetailInfoViewController(nibName:NibNamed.WellDetailInfoViewController.rawValue, bundle:nil)
        
        if let str = selectedDict.object(forKey: "DetailInfo") as? NSDictionary
        {
            wellDetailInfoController.titleName = selectedName
            wellDetailInfoController.detailInfoDict = str as! [String : String]
        }
        else
        {
            wellDetailInfoController.titleName = selectedName
        }
        
        self.navigationController!.pushViewController(wellDetailInfoController, animated: true)
        
    }
    
    @IBAction func backBtnAction(_ sender: Any)
    {
        _ = navigationController?.popViewController(animated: true)
    }
   
}
