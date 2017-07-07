//
//  WellDetailInfoTableViewCell.swift
//  Smart Rod
//
//  Created by Saraschandra on 06/07/17.
//  Copyright © 2017 MobiwareInc. All rights reserved.
//

import UIKit

class WellDetailInfoTableViewCell: UITableViewCell
{
    @IBOutlet var cellBGView: UIView!
    @IBOutlet var cellSeperatorView: UIView!
    
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
