//
//  ACellVC.swift
//  bucketList_5
//
//  Created by J on 7/15/2018.
//  Copyright © 2018 Jman. All rights reserved.
//

import UIKit

class ACellVC: UITableViewCell {

    
    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var descCellLabel: UILabel!
    @IBOutlet weak var dateCellLabel: UILabel!
    
    @IBOutlet weak var urgentCellLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
