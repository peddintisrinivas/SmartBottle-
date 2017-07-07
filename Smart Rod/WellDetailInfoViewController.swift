//
//  WellDetailInfoViewController.swift
//  Smart Rod
//
//  Created by Saraschandra on 06/07/17.
//  Copyright © 2017 MobiwareInc. All rights reserved.
//

import UIKit

class WellDetailInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet var navigationView: UIView!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableViewBGView: UIView!
    @IBOutlet var detailInfoTableVIew: UITableView!
    @IBOutlet var noRecordsView: UIView!
    
    
    let reuseIdentifier = "WellDetailInfoCell"
    
    var titleName = NSString()
    var detailInfoDict = [String : String]()
    
        override func viewDidLoad()
    {
        super.viewDidLoad()

        print("Title Name is : \(titleName)")
        print("DetailInfoDict is : \(detailInfoDict)")
        print("Dictionary key - value count is : \(detailInfoDict.count)")
        
        titleLabel.text = titleName as String;
        
        tableViewBGView.backgroundColor = UIColor.white
        tableViewBGView.layer.cornerRadius = 10.0
        tableViewBGView.layer.masksToBounds = true
        
        tableViewBGView.layer.shadowColor = UIColor.black.cgColor
        tableViewBGView.layer.shadowOpacity = 0.5
        tableViewBGView.layer.shadowOffset = CGSize(width: -1, height: 1)
        tableViewBGView.layer.shadowRadius = 1
        
        tableViewBGView.layer.shadowPath = UIBezierPath(rect: tableViewBGView.bounds).cgPath
        tableViewBGView.layer.shouldRasterize = true
        tableViewBGView.layer.rasterizationScale = UIScreen.main.scale
    
        if(detailInfoDict.count != 0)
        {
           detailInfoTableVIew.isHidden = false
           noRecordsView.isHidden = true
            
        }
        else
        {
            detailInfoTableVIew.isHidden = true
            noRecordsView.isHidden = false
        }

        let nib = UINib(nibName: "WellDetailInfoTableViewCell", bundle: nil)
        detailInfoTableVIew.register(nib, forCellReuseIdentifier: reuseIdentifier)
        detailInfoTableVIew.backgroundColor = UIColor.white
        
        detailInfoTableVIew.delegate = self
        detailInfoTableVIew.dataSource = self
        
        detailInfoTableVIew.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return detailInfoDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: WellDetailInfoTableViewCell = self.detailInfoTableVIew.dequeueReusableCell(withIdentifier: reuseIdentifier) as! WellDetailInfoTableViewCell
       
        let key = Array(detailInfoDict.keys)[indexPath.row]
        let value = Array(detailInfoDict.values)[indexPath.row]
        
        cell.keyLabel.text = key
        cell.valueLabel.text = value
        
        return cell;
    }

    @IBAction func backBtnAction(_ sender: Any)
    {
         _ = navigationController?.popViewController(animated: true)
    }
  
}
