//
//  NoDataTableViewCell.swift
//  MyLineup
//
//  Created by EWW077 on 25/03/20.
//  Copyright © 2020 Mayur iMac. All rights reserved.
//

import UIKit

class NoDataTableViewCell: UITableViewCell {

    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var lblNoDataTitle: UILabel!
    @IBOutlet weak var lblTapToadd: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblNoDataTitle.font = FontBook.regular.font(ofSize: 14)
        
        lblTapToadd.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
