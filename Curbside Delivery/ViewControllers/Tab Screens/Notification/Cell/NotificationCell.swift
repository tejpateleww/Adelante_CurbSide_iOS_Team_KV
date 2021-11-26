//
//  NotificationCell.swift
//  Curbside Delivery
//
//  Created by Tej P on 16/11/21.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vWImage: UIView!
    @IBOutlet weak var imgNoti: UIImageView!
    @IBOutlet weak var lblNotiTitle: UILabel!
    @IBOutlet weak var lblNotiDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.vWImage.layer.cornerRadius = self.vWImage.frame.size.width/2
        self.vWImage.clipsToBounds = true
        
        self.lblNotiTitle.font = FontBook.bold.font(ofSize: 17)
        self.lblNotiDesc.font = FontBook.regular.font(ofSize: 17)
    }
}
