//
//  CustomOnlyPicturesCell.swift
//  Soul Tribe
//
//  Created by MAC-30 on 22/12/21.
//

import UIKit

class CustomOnlyPicturesCell: UICollectionViewCell {

    @IBOutlet weak var imgleadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var countlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 1
    }

}
