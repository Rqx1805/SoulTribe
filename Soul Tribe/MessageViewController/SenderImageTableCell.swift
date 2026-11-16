//
//  SenderImageTableCell.swift
//  Directory Cum
//
//  Created by APPLE on 07/05/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class SenderImageTableCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var ProfileImgView: MyImageView!
    @IBOutlet weak var RecieverImg: MyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = 8
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor(red: 0/255, green: 199/255, blue: 161/255, alpha: 1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
